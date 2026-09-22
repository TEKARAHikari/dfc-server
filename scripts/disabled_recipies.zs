// Farmer's Delight cutting board recipe
<recipetype:farmersdelight:cutting>.removeByName("endersdelight:cutting/ender_shard");
<recipetype:create:crushing>.removeByName("create_ultimate_factory:crushing_netherite");
<recipetype:create:compacting>.removeByName("create_ultimate_factory:compacting_coalblock");
<recipetype:minecraft:crafting>.removeByName("dndesires:crafting/diamond_from_diamond_shard");
<recipetype:dndesires:seething>.removeByName("dndesires:seething/diamond_shard_from_deepslate_coal_ore");
<recipetype:dndesires:seething>.removeByName("dndesires:seething/diamond_shard_from_coal_block");

craftingTable.addShapeless(
    "ender_shard_from_grains",
    <item:endersdelight:ender_shard>,
    [
        <item:ends_delight:ender_pearl_grain>,
        <item:ends_delight:ender_pearl_grain>
    ]
);