{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    ruby_3_3
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.cctools
    libiconv
  ];

  shellHook = ''
    export GEM_HOME="$PWD/.gems"
    export GEM_PATH="$GEM_HOME"
    export PATH="$GEM_HOME/bin:$PATH"

    mkdir -p "$GEM_HOME"

    echo "Ruby $(ruby --version) environment ready"
  '';
}
