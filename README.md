# 🌾 FS25 Farm Tax Manager
**Version:** 1.2.0.0 | CriderGPT Linked Edition  
**Author:** Jessie Crider (CriderGPT)  
**Site:** [https://cridergpt.lovable.app](https://cridergpt.lovable.app)

---

## 🚜 Overview
Farm Tax Manager adds a realistic, Virginia-style tax system to Farming Simulator 25 — now fully integrated with **CriderGPT Helper / Apollo Core** for smarter in-game tracking and AI-driven farm management.

---

## 💡 What’s New in 1.2
- Full **CriderGPT Helper / Apollo Core** integration.  
- Requires **FS25_CriderGPTHelper** mod to run.  
- Automatic **addon registration** inside Apollo Core.  
- HUD branding: `CriderGPT│` prefix for all tax notifications.  
- Improved startup validation and mod dependency checks.  
- Optimized multiplayer synchronization and logging.  
- Certified **console-safe** and **ModHub-ready**.

---

## 💰 What It Does
Implements a clean, transparent taxation system:
- **Property Tax** – based on *owned land area* (ha).  
- **Vehicle Tax** – recurring charge per owned machine.  
- **Sales Tax (5.2%)** – deducted automatically from harvest/product sales.  
- Displays HUD notices for every transaction — no sounds, no UI conflicts.

---

## ⚙️ How It Works
| Tax Type | Trigger | Formula | Default Rate |
|-----------|----------|----------|---------------|
| Property | Every 30 in-game days | `area × 12.5 $/ha` | 12.5 $/ha |
| Vehicle | Every 30 in-game days | `vehicleCount × 25 $` | 25 $ |
| Sales | On income event | `amount × 0.052` | 5.2 % |

> 💾 All transactions use the standard money system (no custom data saved). Works in both single-player and multiplayer.

---

## 🧩 CriderGPT Integration
When FS25_CriderGPTHelper is active:
- The mod **auto-registers** itself in the **Apollo Core** add-on list.  
- HUD and log notifications use **CriderGPT branding**.  
- Apollo Core can read farm balance data for analytics or reporting.  

If the helper mod is missing, Farm Tax Manager will gracefully stop and display:
