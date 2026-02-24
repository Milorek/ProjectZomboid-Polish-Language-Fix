# Project Zomboid - Polish Translation Fix

![Project Zomboid Version](https://img.shields.io/badge/Project_Zomboid-Build_41.78+-darkred.svg)
![Status](https://img.shields.io/badge/Status-Work_in_Progress-yellow.svg)

## About The Project
This mod was created to improve the Polish translation of the Project Zomboid beta version. The official translation contains issues with Polish characters and many untranslated terms.

### Key Features:
* **UI & Hardcoded Strings Fix:** Translated lines deeply buried within the game's Lua scripts.
* **Contextual Accuracy:** Translations are done via active playtesting to ensure proper context (no more blind translations).
* **Consistent Naming Convention:** Standardized item and mechanic names across the entire game (see `GLOSSARY.md`).
* **Encoding Fixes:** Rebuilt files in UTF-8 to eliminate broken Polish characters (ą, ę, ł, etc.).

##  Tech Stack & Tools Used
* **Languages:** Lua, Text (PZ Translation Format)
* **Tools:** Visual Studio Code, Git, Regex (for bulk string fixing), PowerShell (for finding lines missing in the official Polish translation)

##  Roadmap (To-Do List)
- [x] Fix missing Polish characters in main menus
- [ ] Base translation of UI elements
- [ ] Overhaul crafting recipes translation
- [ ] Standardize all item names with recipes
- [ ] Translate newly added hardcoded strings in Build 42+

##  Installation (For Players)
1. Subscribe to the mod on [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3659270155)
OR
2. Download the latest release from GitHub and place the folder in `C:\Users\YourName\Zomboid\mods`

---
*Created by Milorek - Computer Science Student & Indie Game Dev enthusiast.*