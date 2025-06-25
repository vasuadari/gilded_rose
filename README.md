# Gilded Rose Refactoring Kata

This project is a refactoring of the Gilded Rose Kata, transforming messy legacy code into a clean, extensible, and maintainable object-oriented solution in ruby.

---

## The Starting Point: A Messy `update_quality`

The original code had one big `GildedRose.update_quality` method packed with `if/else if` statements. It handled all item rules (normal, Aged Brie, Sulfuras, Backstage Passes, Conjured) in one place, making it a nightmare to change or add new item types.

**Constraint:** The original `Item` class cannot be modified.

---

## Assumptions

This refactoring is based on the following interpretations and assumptions of the Gilded Rose Kata rules:

1.  **Item Names and Consistency:**
    * Item names (e.g., "Aged Brie", "Sulfuras, Hand of Ragnaros", "Backstage passes to a TAFKAL80ETC concert", "Conjured Mana Cake") are treated as **exact string matches or prefixes** for determining item type and properties.
    * The "Conjured" property is always indicated by the string `"Conjured"` appearing *within* the item's name (e.g., "Conjured Mana Cake", "Conjured Backstage passes").

2.  **"Conjured" Rule Specificity:**
    * The rule "Conjured items degrade in Quality twice as fast" is interpreted to apply **only to items whose quality would normally *decrease***.
    * Items whose quality normally *increases* (like "Aged Brie" or "Backstage passes" before the concert) are *not* affected by the "twice as fast" rule; their quality will continue to increase at their normal rate if they are also "Conjured."
    * Items whose quality never changes (like "Sulfuras") are also unaffected by the "Conjured" property.

3.  **Quality Boundaries:**
    * Item `quality` always remains within the bounds of `0` (inclusive) and `50` (inclusive), except for "Sulfuras," whose quality is always `80`. The `QualityManager` enforces these `0-50` bounds.

4.  **`Item` Class Immutability:**
    * The provided `Item` class cannot be modified (no new methods, fields, or changes to existing ones). This necessitates the "wrapper" (Decorator) approach.

5.  **`GildedRose` Public Interface:**
    * The public methods (`initialize` and `update_quality`) and the public `items` property (or `items_to_update` as you renamed it internally) of the `GildedRose` class are maintained for external compatibility (e.g., with existing test suites).

6.  **"Mana Cake" as a Standard Item:**
    * "Mana Cake" (when not "Conjured") behaves as a standard degrading item. "Conjured Mana Cake" is treated as a standard item with the "Conjured" property applied.

### Out of Scope

* Ideally, this will be used as a gem in production application which will ensure how to run it daily.

---

## My Approach: Embracing Object-Oriented Design

The core idea was to stop asking "what kind of item are you?" and instead "tell the item to update itself."

### 1. **Item Behavior in Item Classes**

* **Problem:** One method knew all item rules.
* **Solution:** I created a hierarchy of classes (`GildedRose::Items::UpdatableItem` and its specific subclasses like `AgedBrie`, `BackstagePasses`, `Sulfuras`).
    * Each class now knows how to calculate its *own* daily quality change (`calculate_quality_change`).
    * Common aging (`age_item`) and quality bounds (via `QualityManager`) logic is shared.
* **Result:** Adding a new item type means creating a new class, not changing existing ones.

### 2. **"Conjured" as a Property (Decorator Pattern)**

* **Problem:** "Conjured" (degrade twice as fast for degrading items) isn't a new item *type* (e.g., you can have "Conjured Aged Brie").
* **Solution:** I used the **Decorator Pattern**.
    * `GildedRose::Items::ConjuredDecorator` wraps any `UpdatableItem`.
    * It modifies the wrapped item's `calculate_quality_change` to double the degradation, but only if the quality would normally decrease.
* **Result:** The "Conjured" rule is neatly applied without polluting base item classes or creating endless subclasses.

### 3. **Clean Creation (Factory Pattern)**

* **Problem:** The `GildedRose` class was cluttered with `case` statements deciding which item class to create.
* **Solution:** A `GildedRose::ItemFactory` module now handles all the logic for building the correct `UpdatableItem` (and applying the `ConjuredDecorator` if needed).
* **Result:** `GildedRose`'s `initialize` method is super clean, simply asking the factory for a ready-to-update item.

---

## The Outcome: Clean, Flexible Code

The refactored code is:

* **Easy to Understand:** Each class has a clear job.
* **Easy to Extend:** Adding new item types or properties is straightforward, often requiring no changes to core `GildedRose` logic.
* **Robust:** Less prone to bugs when rules change.

---

## How to Run / Tests

```bash
bundle install
bundle exec rspec
```

## For daily simulation

```bash
bundle install
bin/gilded_rose
bin/gilded_rose 10
```
