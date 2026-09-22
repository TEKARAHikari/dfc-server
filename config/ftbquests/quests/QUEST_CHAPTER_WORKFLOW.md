# Quest Chapter Authoring Workflow

Use this checklist whenever a new FTB Quests chapter is added.

## 1. Inspect the new chapter

- Read `chapters/<chapter>.snbt` and list every top-level quest ID and its task item, entity, or fluid.
- Check `lang/en_us.snbt` for existing chapter titles or quest text before adding anything.
- Treat task IDs, reward IDs, and quest IDs as separate identifiers.

## 2. Research what each quest item actually does

- Prefer the installed mod JAR: language files, recipes, Ponder scenes, tooltips, advancements, and loot tables.
- Check the mod's official CurseForge, Modrinth, wiki, or source page when the JAR does not explain behavior clearly.
- Do not infer mechanics from an item name. Mention important interactions, limitations, recipes, fluids, and set bonuses when relevant.

## 3. Write descriptions in this pack's style

Each quest gets one practical explanation, one empty string, and one playful closing line:

```snbt
	quest.QUEST_ID.quest_desc: [
		"Explain what the item does and how it is used."
		""
		"Finish with a short joke or flavorful line."
	]
	quest.QUEST_ID.quest_subtitle: "A short, distinct tagline"
```

Important formatting rules:

- Use `.quest_desc` and `.quest_subtitle` exactly.
- Description strings are on separate lines with **no commas** between them.
- Keep an empty string between the explanation and playful ending.
- Do not use inline arrays such as `["First", "", "Last"]`.
- Preserve `lang/en_us.snbt` as UTF-8 without changing its existing BOM or line endings.

## 4. Add XP rewards

Add one reward inside each quest, immediately before `tasks`:

```snbt
			rewards: [{
				id: "UNIQUE_16_HEX_ID"
				type: "xp"
				xp: 40
			}]
```

Scale XP by actual acquisition difficulty. Suggested guide:

- `5-10`: trivial crafting or common materials
- `20-40`: modest processing, exploration, or uncommon ingredients
- `80`: advanced machinery or expensive components
- `120-160`: major progression, rare loot, or lengthy processing
- `200+`: top-tier equipment or exceptionally demanding goals

Every reward ID must be unique across the quest data.

## 5. Validate before finishing

- Every new quest has exactly one XP reward.
- Every quest has both `.quest_desc` and `.quest_subtitle` entries.
- Every description uses multiline strings with no comma delimiters.
- Every description contains the empty-string separator.
- No stale `.description` or `.subtitle` keys were introduced.
- Reward IDs are unique.
- Braces are balanced in both edited SNBT files.
- Encoding and line endings were preserved.
- Inspect at least one finished block visually against a known-good chapter such as Misc.
