{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    ruby_3_3

    bundler

    # macOS-specific build tools
    darwin.cctools
    libiconv

    # System dependencies often needed for gems
    gcc
    gnumake
    pkg-config

    # Common libraries for Ruby gems (macOS compatible versions)
    openssl
    libffi
    readline
    zlib
    libyaml
  ];

  shellHook = ''
    echo "Ruby development environment loaded for macOS!"
    echo "Ruby version: $(ruby --version)"
    echo "Bundler version: $(bundle --version)"

    # Set up gem installation directory in project
    export GEM_HOME="$PWD/.gems"
    export GEM_PATH="$GEM_HOME"
    export PATH="$GEM_HOME/bin:$PATH"

    # macOS-specific environment variables
    export MACOSX_DEPLOYMENT_TARGET="10.15"
    export LDFLAGS="-L${pkgs.openssl}/lib -L${pkgs.libffi}/lib -L${pkgs.libiconv}/lib"
    export CPPFLAGS="-I${pkgs.openssl}/include -I${pkgs.libffi}/include -I${pkgs.libiconv}/include"
    export PKG_CONFIG_PATH="${pkgs.openssl}/lib/pkgconfig:${pkgs.libffi}/lib/pkgconfig"

    # Fix for nokogiri and other gems that need libxml2
    export BUNDLE_BUILD__NOKOGIRI="--use-system-libraries --with-xml2-include=${pkgs.libxml2}/include/libxml2"

    # Create gems directory if it doesn't exist
    mkdir -p "$GEM_HOME"

    echo "Environment configured for macOS Ruby development"
  '';
}
