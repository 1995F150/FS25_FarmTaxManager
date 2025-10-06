# 🌾 FS25 Farm Tax Manager
**Version:** 1.1.0.0  
**Author:** Jessie Crider (CriderGPT)  
**Site:** https://cridergpt.lovable.app

---

## What it does
A clean, console-safe tax system modeled on Virginia. It automatically charges:
- **Property Tax** – based on *owned land area* (ha).
- **Vehicle Tax** – small recurring fee per owned machine.
- **Sales Tax (5.2% by default)** – deducted automatically from harvest/product sale income.

All actions are shown via HUD messages (no sounds, no external deps). Works SP/MP.

---

## How it works (default)
- **Property & vehicle tax**: charged every **30 in-game days**.
- **Sales tax**: taken when **income is added** from harvest/product sales.
- Saves no personal data; uses the standard money system only.

---

## Configure (edit in `scripts/FarmTaxManager.lua`)
```lua
self.taxIntervalDays = 30       -- property/vehicle tax cadence (days)
self.landTaxRate     = 12.5     -- $ per hectare
self.vehicleTaxRate  = 25.0     -- $ per vehicle
self.salesTaxRate    = 0.052    -- 5.2% sales tax
