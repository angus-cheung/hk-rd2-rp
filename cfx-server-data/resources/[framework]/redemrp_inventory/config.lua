Config = {}

Config.MaxWeight = 24.0 -- kg

Config.Crafting = {
    ["bandage"] = {
        items = {
            "empty","empty","empty",
            "cotton,3","purealcohol","empty",
            "empty","empty","empty"
        },
    },

    ["mbandage"] = {
        items = {
            "empty","empty","empty",
            "cotton,3","purealcohol,2","ginseng",
            "empty","empty","empty"
        },
        requireId = "cooking",
        requireJob = { "doctor" },
    },

    -------- cooking
    --
    --

    
    ["bread"] = {
        items = {
            "empty","flour","empty",
            "empty","water","empty",
            "empty","empty","empty"
        },
        requireId = "cooking",
    },
}

Config.Items = {
    ["water"] = {
        label = "水",
        description = "一些清涼的水，保持你的水分",
        weight = 0.01,
        canBeDropped = true,
        canBeUsed = true,
        limit = 200,
        imgsrc = "items/water.png",
        type = "item_standard"
    },
    ["bandage"] = {
        label = "繃帶",
        description = "用來治療傷口並恢復健康的繃帶",
        weight = 0.2,
        canBeDropped = true,
        canBeUsed = true,
        limit = 100,
        imgsrc = "items/bandage.png",
        type = "item_standard"
    },
    ["mbandage"] = {
        label = "藥膏繃帶",
        description = "用來治療傷口並更快地恢復健康的藥膏繃帶",
        weight = 0.2,
        canBeDropped = true,
        canBeUsed = true,
        limit = 100,
        imgsrc = "items/mbandage.png",
        type = "item_standard"
    },
    ["WEAPON_REVOLVER_CATTLEMAN"] = {
        label = "牛仔左輪手槍",
        description = "牛仔左輪手槍",
        weight = 0.5,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_REVOLVER_CATTLEMAN"),
        imgsrc = "items/WEAPON_REVOLVER_CATTLEMAN.png",
        type = "item_weapon"
    },
    ["WEAPON_REVOLVER_DOUBLEACTION"] = {
        label = "雙動作手槍",
        description = "雙動作手槍",
        weight = 0.5,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_REVOLVER_DOUBLEACTION"),
        imgsrc = "items/WEAPON_REVOLVER_DOUBLEACTION.png",
        type = "item_weapon"
    },
    ["WEAPON_REVOLVER_NAVY"] = {
        label = "海軍左輪手槍",
        description = "海軍左輪手槍",
        weight = 0.5,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_REVOLVER_NAVY"),
        imgsrc = "items/weapon_revolver_navy.png",
        type = "item_weapon",
    },
    ["WEAPON_PISTOL_VOLCANIC"] = {
        label = "火山手槍",
        description = "火山手槍",
        weight = 0.5,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_PISTOL_VOLCANIC"),
        imgsrc = "items/WEAPON_PISTOL_VOLCANIC.png",
        type = "item_weapon"
    },
    ["WEAPON_PISTOL_SEMIAUTO"] = {
        label = "半自動手槍",
        description = "半自動手槍",
        weight = 0.5,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_PISTOL_SEMIAUTO"),
        imgsrc = "items/WEAPON_PISTOL_SEMIAUTO.png",
        type = "item_weapon"
    },
    ["WEAPON_PISTOL_MAUSER"] = {
        label = "毛瑟手槍",
        description = "毛瑟手槍",
        weight = 0.5,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_PISTOL_MAUSER"),
        imgsrc = "items/WEAPON_PISTOL_MAUSER.png",
        type = "item_weapon"
    },
    ["WEAPON_PISTOL_M1899"] = {
        label = "M1899手槍",
        description = "M1899手槍",
        weight = 0.5,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_PISTOL_M1899"),
        imgsrc = "items/m1899.png",
        type = "item_weapon"
    },
    ["WEAPON_REVOLVER_LEMAT"] = {
        label = "雷馬左輪手槍",
        description = "雷馬左輪手槍",
        weight = 0.5,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_REVOLVER_LEMAT"),
        imgsrc = "items/WEAPON_REVOLVER_LEMAT.png",
        type = "item_weapon"
    },
    ["WEAPON_REVOLVER_SCHOFIELD"] = {
        label = "斯科菲爾德左輪手槍",
        description = "斯科菲爾德左輪手槍",
        weight = 0.7,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_REVOLVER_SCHOFIELD"),
        imgsrc = "items/WEAPON_REVOLVER_SCHOFIELD.png",
        type = "item_weapon"
    },
    --REAPEATERS
    ["WEAPON_REPEATER_CARBINE"] = {
        label = "卡賓步",
        description = "卡賓步",
        weight = 0.9,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_REPEATER_CARBINE"),
        imgsrc = "items/WEAPON_REPEATER_CARBINE.png",
        type = "item_weapon"
    },
    ["WEAPON_REPEATER_EVANS"] = {
        label = "伊凡斯卡賓步",
        description = "伊凡斯卡賓步",
        weight = 0.9,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_REPEATER_EVANS"),
        imgsrc = "items/WEAPON_REPEATER_EVANS.png",
        type = "item_weapon"
    },
    ["WEAPON_REPEATER_HENRY"] = {
        label = "亨利卡賓步",
        description = "亨利卡賓步",
        weight = 0.9,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_REPEATER_HENRY"),
        imgsrc = "items/WEAPON_REPEATER_HENRY.png",
        type = "item_weapon"
    },
    ["WEAPON_REPEATER_WINCHESTER"] = {
        label = "溫徹斯特卡賓步",
        description = "溫徹斯特卡賓步",
        weight = 0.9,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_REPEATER_WINCHESTER"),
        imgsrc = "items/WEAPON_REPEATER_LANCASTER.png",
        type = "item_weapon"
    },
    --RIFLES
    ["WEAPON_RIFLE_VARMINT"] = {
        label = "獵槍",
        description = "獵槍",
        weight = 0.9,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_RIFLE_VARMINT"),
        imgsrc = "items/WEAPON_RIFLE_VARMINT.png",
        type = "item_weapon"
    },
    ["WEAPON_RIFLE_BOLTACTION"] = {
        label = "螺栓動作步槍",
        description = "螺栓動作步槍",
        weight = 0.9,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_RIFLE_BOLTACTION"),
        imgsrc = "items/WEAPON_RIFLE_BOLTACTION.png",
        type = "item_weapon"
    },
    ["WEAPON_SNIPERRIFLE_CARCANO"] = {
        label = "卡爾卡諾狙擊步槍",
        description = "卡爾卡諾狙擊步槍",
        weight = 0.9,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_SNIPERRIFLE_CARCANO"),
        imgsrc = "items/WEAPON_SNIPERRIFLE_CARCANO.png",
        type = "item_weapon"
    },
    ["WEAPON_SNIPERRIFLE_ROLLINGBLOCK"] = {
        label = "滾簧槍狙擊步槍",
        description = "滾簧槍狙擊步槍",
        weight = 0.9,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_SNIPERRIFLE_ROLLINGBLOCK"),
        imgsrc = "items/WEAPON_SNIPERRIFLE_ROLLINGBLOCK.png",
        type = "item_weapon"
    },
    ["WEAPON_RIFLE_SPRINGFIELD"] = {
        label = "斯普林菲爾德步槍",
        description = "斯普林菲爾德步槍",
        weight = 0.9,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_RIFLE_SPRINGFIELD"),
        imgsrc = "items/WEAPON_RIFLE_SPRINGFIELD.png",
        type = "item_weapon"
    },
    --SHOTGUNS
    ["WEAPON_SHOTGUN_PUMP"] = {
        label = "泵動霰彈槍",
        description = "泵動霰彈槍",
        weight = 0.9,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_SHOTGUN_PUMP"),
        imgsrc = "items/WEAPON_SHOTGUN_PUMP.png",
        type = "item_weapon"
    },
    ["WEAPON_SHOTGUN_REPEATING"] = {
        label = "重複霰彈槍",
        description = "重複霰彈槍",
        weight = 0.9,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_SHOTGUN_REPEATING"),
        imgsrc = "items/WEAPON_SHOTGUN_REPEATING.png",
        type = "item_weapon"
    },
    ["WEAPON_SHOTGUN_DOUBLEBARREL"] = {
        label = "雙管霰彈槍",
        description = "雙管霰彈槍",
        weight = 0.9,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_SHOTGUN_DOUBLEBARREL"),
        imgsrc = "items/WEAPON_SHOTGUN_DOUBLEBARREL.png",
        type = "item_weapon"
    },
    ["WEAPON_SHOTGUN_SAWEDOFF"] = {
        label = "短管霰彈槍",
        description = "短管霰彈槍",
        weight = 0.9,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_SHOTGUN_SAWEDOFF"),
        imgsrc = "items/WEAPON_SHOTGUN_SAWEDOFF.png",
        type = "item_weapon"
    },
    ["WEAPON_SHOTGUN_SEMIAUTO"] = {
        label = "半自動霰彈槍",
        description = "半自動霰彈槍",
        weight = 0.9,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_SHOTGUN_SEMIAUTO"),
        imgsrc = "items/WEAPON_SHOTGUN_SEMIAUTO.png",
        type = "item_weapon"
    },
    --MELEE WEAPONS
    ["WEAPON_MELEE_HATCHET_HUNTER"] = {
        label = "獵人戰斧",
        description = "用於狩獵野生動物",
        weight = 1.0,
        canBeDropped = true,
        requireLvl = 1,
        weaponHash = GetHashKey("WEAPON_MELEE_HATCHET_HUNTER"),
        imgsrc = "items/WEAPON_MELEE_HATCHET_HUNTER.png",
        type = "item_weapon"
    },
    ["WEAPON_MELEE_HATCHET_DOUBLE_BIT"] = {
        label = "雙刃戰斧",
        description = "用於狩獵野生動物",
        weight = 1.0,
        canBeDropped = true,
        requireLvl = 1,
        weaponHash = GetHashKey("WEAPON_MELEE_HATCHET_DOUBLE_BIT"),
        imgsrc = "items/WEAPON_MELEE_HATCHET_DOUBLE_BIT.png",
        type = "item_weapon"
    },
    ["WEAPON_MELEE_CLEAVER"] = {
        label = "屠夫刀",
        description = "切勿讓兒童接觸",
        weight = 1.0,
        canBeDropped = true,
        requireLvl = 1,
        weaponHash = GetHashKey("WEAPON_MELEE_CLEAVER"),
        imgsrc = "items/WEAPON_MELEE_CLEAVER.png",
        type = "item_weapon"
    },
    ["WEAPON_MELEE_KNIFE_JAWBONE"] = {
        label = "顎骨刀",
        description = "象徵高雅品味",
        weight = 1.0,
        canBeDropped = true,
        requireLvl = 1,
        weaponHash = GetHashKey("WEAPON_MELEE_KNIFE_JAWBONE"),
        imgsrc = "items/WEAPON_MELEE_KNIFE_JAWBONE.png",
        type = "item_weapon"
    },
    ["WEAPON_MELEE_KNIFE_TRADER"] = {
        label = "商人刀",
        description = "象徵高雅品味",
        weight = 1.0,
        canBeDropped = true,
        requireLvl = 1,
        weaponHash = GetHashKey("WEAPON_MELEE_KNIFE_TRADER"),
        imgsrc = "items/WEAPON_MELEE_KNIFE_TRADER.png",
        type = "item_weapon"
    },
    ["WEAPON_MELEE_KNIFE_HORROR"] = {
        label = "恐怖刀",
        description = "象徵高雅品味",
        weight = 1.0,
        canBeDropped = true,
        requireLvl = 1,
        weaponHash = GetHashKey("WEAPON_MELEE_KNIFE_HORROR"),
        imgsrc = "items/WEAPON_MELEE_KNIFE_HORROR.png",
        type = "item_weapon"
    },
    ["WEAPON_MELEE_KNIFE_RUSTIC"] = {
        label = "鄉村刀",
        description = "象徵高雅品味",
        weight = 1.0,
        canBeDropped = true,
        requireLvl = 1,
        weaponHash = GetHashKey("WEAPON_MELEE_KNIFE_RUSTIC"),
        imgsrc = "items/WEAPON_MELEE_KNIFE_RUSTIC.png",
        type = "item_weapon"
    },
    ["WEAPON_MELEE_MACHETE"] = {
        label = "獵刀",
        description = "獵刀",
        weight = 1,
        canBeDropped = true,
        requireLvl = 1,
        weaponHash = GetHashKey("WEAPON_MELEE_MACHETE"),
        imgsrc = "items/WEAPON_MELEE_MACHETE.png",
        type = "item_weapon"
    },
    ["WEAPON_MELEE_MACHETE_HORROR"] = {
        label = "恐怖獵刀",
        description = "恐怖獵刀",
        weight = 1,
        canBeDropped = true,
        requireLvl = 1,
        weaponHash = GetHashKey("WEAPON_MELEE_MACHETE_HORROR"),
        imgsrc = "items/WEAPON_MELEE_MACHETE_HORROR.png",
        type = "item_weapon"
    },
    ["WEAPON_MELEE_MACHETE_COLLECTOR"] = {
        label = "收藏家獵刀",
        description = "收藏家獵刀",
        weight = 1,
        canBeDropped = true,
        requireLvl = 1,
        weaponHash = GetHashKey("WEAPON_MELEE_MACHETE_COLLECTOR"),
        imgsrc = "items/WEAPON_MELEE_MACHETE_COLLECTOR.png",
        type = "item_weapon"
    },
    ["WEAPON_MELEE_KNIFE"] = {
        label = "小刀",
        description = "小刀",
        weight = 0.5,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_MELEE_KNIFE"),
        imgsrc = "items/WEAPON_MELEE_KNIFE.png",
        type = "item_weapon"
    },
    ["WEAPON_MELEE_LANTERN"] = {
        label = "提燈",
        description = "提燈",
        weight = 0.5,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_MELEE_LANTERN"),
        imgsrc = "items/generic_horse_equip_lantern.png",
        type = "item_weapon"
    },
    ["WEAPON_MELEE_TORCH"] = {
        label = "火炬",
        description = "火炬",
        weight = 0.5,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_MELEE_TORCH"),
        imgsrc = "items/WEAPON_MELEE_TORCH.png",
        type = "item_weapon"
    },
    ["WEAPON_LANTERN_ELECTRIC"] = {
        label = "電動提燈",
        description = "電動提燈",
        weight = 0.5,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_MELEE_LANTERN_ELECTRIC"),
        imgsrc = "items/weapon_melee_electric_lantern.png",
        type = "item_weapon"
    },
    ["WEAPON_BOW"] = {
        label = "弓",
        description = "弓",
        weight = 0.25,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_BOW"),
        imgsrc = "items/WEAPON_BOW.png",
        type = "item_weapon"
    },
    ["WEAPON_BOW_IMPROVED"] = {
        label = "改進型弓",
        description = "改進型弓",
        weight = 0.25,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_BOW_IMPROVED"),
        imgsrc = "items/T_Bow_01ca.png",
        type = "item_weapon"
    },
    ["WEAPON_LASSO"] = {
        label = "套索",
        description = "套索",
        weight = 0.25,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_LASSO_REINFORCED"),
        imgsrc = "items/WEAPON_LASSO.png",
        type = "item_weapon"
    },
    ["WEAPON_MELEE_HATCHET"] = {
        label = "戰斧",
        description = "戰斧",
        weight = 0.5,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_MELEE_HATCHET"),
        imgsrc = "items/WEAPON_MELEE_HATCHET.png",
        type = "item_weapon"
    },
    ["WEAPON_THROWN_THROWING_KNIVES"] = {
        label = "飛刀",
        description = "飛刀",
        weight = 0.5,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_THROWN_THROWING_KNIVES"),
        imgsrc = "items/WEAPON_THROWN_THROWING_KNIVES.png",
        type = "item_weapon"
    },
    ["WEAPON_THROWN_TOMAHAWK"] = {
        label = "戰斧",
        description = "戰斧",
        weight = 0.5,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_THROWN_TOMAHAWK"),
        imgsrc = "items/WEAPON_THROWN_TOMAHAWK.png",
        type = "item_weapon"
    },
    ["WEAPON_THROWN_DYNAMITE"] = {
        label = "炸藥棒",
        description = "炸藥棒",
        weight = 0.5,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_THROWN_DYNAMITE"),
        imgsrc = "items/WEAPON_THROWN_DYNAMITE.png",
        type = "item_weapon"
    },
    ["WEAPON_THROWN_MOLOTOV"] = {
        label = "燃燒彈",
        description = "燃燒彈",
        weight = 0.25,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_THROWN_MOLOTOV"),
        imgsrc = "items/WEAPON_THROWN_MOLOTOV.png",
        type = "item_weapon"
    },
    ["WEAPON_KIT_BINOCULARS"] = {
        label = "望遠鏡",
        description = "望遠鏡",
        weight = 0.25,
        canBeDropped = true,
        weaponHash = GetHashKey("WEAPON_KIT_BINOCULARS"),
        imgsrc = "items/WEAPON_KIT_BINOCULARS.png",
        type = "item_weapon"
    },
}
exports("GetItemsList", function()
    return Config.Items
end)
