RedEM = exports["redem_roleplay"]:RedEM()

BucketId = GetRandomIntInRange(0, 0xffffff)
ComponentsMale = {}
ComponentsFemale = {}
LoadedComponents = {}
CreatorCache = {}
local SpawnedPeds = {}
MenuData = {}
TriggerEvent("redemrp_menu_base:getData", function(call)
    MenuData = call
end)

local MainMenus = {
    ["body"] = function()
        OpenBodyMenu()
    end,
    ["face"] = function()
        OpenFaceMenu()
    end,
    ["hair"] = function()
        OpenHairMenu()
    end,
    ["makeup"] = function()
        OpenMakeupMenu()
    end,
    ["save"] = function()
		TriggerServerEvent("rdr_creator:SetPlayerBucket" , 0)
        -- if NetworkIsInTutorialSession() then
        --     NetworkEndTutorialSession()
        -- end
        EndCharacterCreatorCam()
        MenuData.CloseAll()
        LoadedComponents = CreatorCache
        TriggerServerEvent("rdr_creator:SaveSkin", CreatorCache)
        TriggerEvent("redemrp_respawn:respawn", true)
    end
}
local BodyFunctions = {
    ["head"] = function(target, data)
        -- print("test")
        LoadHead(target, data)
        LoadOverlays(target, data)
    end,
    ["face_width"] = function(target, data)
        LoadFeatures(target, data)
    end,
    ["skin_tone"] = function(target, data)
        LoadBody(target, data)
        LoadOverlays(target, data)
    end,
    ["body_size"] = function(target, data)
        LoadBodySize(target, data)
        LoadBody(target, data)
    end,
    ["body_waist"] = function(target, data)
        LoadBodyWaist(target, data)
    end,
    ["height"] = function(target, data)
        LoadHeight(target, data)
    end,
}

local FaceFunctions = {
    ["eyes"] = function()
        OpenEyesMenu()
    end,
    ["eyelids"] = function()
        OpenEyelidsMenu()
    end,
    ["eyebrows"] = function()
        OpenEyebrowsMenu()
    end,
    ["nose"] = function()
        OpenNoseMenu()
    end,
    ["mouth"] = function()
        OpenMouthMenu()
    end,
    ["cheekbones"] = function()
        OpenCheekbonesMenu()
    end,
    ["jaw"] = function()
        OpenJawMenu()
    end,
    ["ears"] = function()
        OpenEarsMenu()
    end,
    ["chin"] = function()
        OpenChinMenu()
    end,
    ["defects"] = function()
        OpenDefectsMenu()
    end

}

local HairFunctions = {
    ["hair"] = function(target, data)
        LoadHair(target, data)
    end,
    ["beard"] = function(target, data)
        LoadBeard(target, data)
    end

}

local EyesFunctions = {
    ["eyes_color"] = function(target, data)
        LoadEyes(target, data)
    end,
    ["eyes_depth"] = function(target, data)
        LoadFeatures(target, data)
    end,
    ["eyes_angle"] = function(target, data)
        LoadFeatures(target, data)
    end,
    ["eyes_distance"] = function(target, data)
        LoadFeatures(target, data)
    end

}

local EyelidsFunctions = {
    ["eyelid_height"] = function(target, data)
        LoadFeatures(target, data)
    end,
    ["eyelid_width"] = function(target, data)
        LoadFeatures(target, data)
    end
}

local EyebrowsFunctions = {
    ["eyebrows_t"] = function(target, data)
        LoadOverlays(target, data)
    end,
    ["eyebrows_op"] = function(target, data)
        LoadOverlays(target, data)
    end,
    ["eyebrows_id"] = function(target, data)
        LoadOverlays(target, data)
    end,
    ["eyebrows_c1"] = function(target, data)
        LoadOverlays(target, data)
    end,
    ["eyebrow_height"] = function(target, data)
        LoadFeatures(target, data)
    end,
    ["eyebrow_width"] = function(target, data)
        LoadFeatures(target, data)
    end,
    ["eyebrow_depth"] = function(target, data)
        LoadFeatures(target, data)
    end
}

Citizen.CreateThread(function()
    for i, v in pairs(cloth_hash_names) do
        if v.category_hashname == "BODIES_LOWER" or v.category_hashname == "BODIES_UPPER" or v.category_hashname ==
            "heads" or v.category_hashname == "hair" or v.category_hashname == "teeth" or v.category_hashname == "eyes" then
            if v.ped_type == "female" and v.is_multiplayer and v.hashname ~= "" then
                if ComponentsFemale[v.category_hashname] == nil then
                    ComponentsFemale[v.category_hashname] = {}
                end
                table.insert(ComponentsFemale[v.category_hashname], v.hash)
            elseif v.ped_type == "male" and v.is_multiplayer and v.hashname ~= "" then
                if ComponentsMale[v.category_hashname] == nil then
                    ComponentsMale[v.category_hashname] = {}
                end

                table.insert(ComponentsMale[v.category_hashname], v.hash)
            end
        end
    end
    if not IsImapActive(183712523) then
        RequestImap(183712523) -- CharacterCreator
    end
    if not IsImapActive(-1699673416) then
        RequestImap(-1699673416) -- CharacterCreator
    end
    if not IsImapActive(1679934574) then
        RequestImap(1679934574) -- CharacterCreator
    end
end)

local onCooldown = false

RegisterNetEvent('RedEM:client:ApplySkin')
AddEventHandler('RedEM:client:ApplySkin', function(SkinData, Target, ClothesData)
    Citizen.CreateThread(function()
        local _Target = Target or PlayerPedId()
        local _SkinData = SkinData
        local health = GetEntityHealth(_Target) -- Get health value
        local healthCore = GetAttributeCoreValue(_Target, 0) -- Get health core value
        if _Target == PlayerPedId() then
            local model = GetPedModel(tonumber(_SkinData.sex))
            LoadModel(PlayerPedId(), model)
            _Target = PlayerPedId()
            SetEntityAlpha(_Target, 0)
            LoadedComponents = _SkinData
        end
        SetEntityHealth(_Target, health) -- Set health back to what it was
        Citizen.InvokeNative( 0xC6258F41D86676E0, _Target, 0, healthCore) -- Set Health Core back to what it was
        print("Loading...")
        -- print(_Target, PlayerPedId())
        FixIssues(_Target, _SkinData)
        LoadBody(_Target, _SkinData)
        LoadHead(_Target, _SkinData)
        LoadHair(_Target, _SkinData)
        LoadBeard(_Target, _SkinData)
        LoadEyes(_Target, _SkinData)
        LoadFeatures(_Target, _SkinData)
        LoadBodySize(_Target, _SkinData)
        LoadBodyWaist(_Target, _SkinData)
        LoadOverlays(_Target, _SkinData)
        LoadHeight(_Target, _SkinData)
        TriggerServerEvent("redemrp_respawn:TestDeathStatus")
        SetEntityAlpha(_Target, 255)
        TriggerEvent("rdr_creator:SkinLoaded", _SkinData, _Target, ClothesData)
        if _Target == PlayerPedId() then
            TriggerServerEvent("rdr_clothes_store:LoadClothes", 1)
            TriggerServerEvent("redemrp_clothing:loadClothes", 1)
        else
            TriggerEvent("rdr_clothes_store:ApplyClothes", ClothesData, _Target)
            for i, m in pairs(overlay_all_layers) do
                overlay_all_layers[i] = {
                    name = m.name,
                    visibility = 0,
                    tx_id = 1,
                    tx_normal = 0,
                    tx_material = 0,
                    tx_color_type = 0,
                    tx_opacity = 1.0,
                    tx_unk = 0,
                    palette = 0,
                    palette_color_primary = 0,
                    palette_color_secondary = 0,
                    palette_color_tertiary = 0,
                    var = 0,
                    opacity = 0.0
                }
            end
        end  
    end)
end)

RegisterNetEvent('RedEM:client:ApplySkinCommand', function(SkinData, Target, ClothesData)
    Citizen.CreateThread(function()
        if not onCooldown then
            onCooldown = true
            doCooldown()
            local _Target = Target or PlayerPedId()
            local _SkinData = SkinData
            local health = GetEntityHealth(_Target) -- Get health value
            local healthCore = GetAttributeCoreValue(_Target, 0) -- Get health core value
            if _Target == PlayerPedId() then
                local model = GetPedModel(tonumber(_SkinData.sex))
                LoadModel(PlayerPedId(), model)
                _Target = PlayerPedId()
                SetEntityAlpha(_Target, 0)
                LoadedComponents = _SkinData
            end
            SetEntityHealth(_Target, health) -- Set health back to what it was
            Citizen.InvokeNative( 0xC6258F41D86676E0, _Target, 0, healthCore) -- Set Health Core back to what it was
            print("Loading...")
            -- print(_Target, PlayerPedId())
            FixIssues(_Target, _SkinData)
            LoadBody(_Target, _SkinData)
            LoadHead(_Target, _SkinData)
            LoadHair(_Target, _SkinData)
            LoadBeard(_Target, _SkinData)
            LoadEyes(_Target, _SkinData)
            LoadFeatures(_Target, _SkinData)
            LoadBodySize(_Target, _SkinData)
            LoadBodyWaist(_Target, _SkinData)
            LoadOverlays(_Target, _SkinData)
            LoadHeight(_Target, _SkinData)
            TriggerServerEvent("redemrp_respawn:TestDeathStatus")
            SetEntityAlpha(_Target, 255)
            TriggerEvent("rdr_creator:SkinLoaded", _SkinData, _Target, ClothesData)
            if _Target == PlayerPedId() then
                TriggerServerEvent("rdr_clothes_store:LoadClothes", 1)
                TriggerServerEvent("redemrp_clothing:loadClothes", 1)
            else
                TriggerEvent("rdr_clothes_store:ApplyClothes", ClothesData, _Target)
                for i, m in pairs(overlay_all_layers) do
                    overlay_all_layers[i] = {
                        name = m.name,
                        visibility = 0,
                        tx_id = 1,
                        tx_normal = 0,
                        tx_material = 0,
                        tx_color_type = 0,
                        tx_opacity = 1.0,
                        tx_unk = 0,
                        palette = 0,
                        palette_color_primary = 0,
                        palette_color_secondary = 0,
                        palette_color_tertiary = 0,
                        var = 0,
                        opacity = 0.0
                    }
                end
            end
        else
            RedEM.Functions.NotifyRight("You can only use this command once every 3 seconds!", 3000)
        end  
    end)
end)

function doCooldown()
    Citizen.CreateThread(function()
        Wait(3000)
        onCooldown = false
    end)
end

RegisterNetEvent('rdr_creator:OpenCreator')
AddEventHandler('rdr_creator:OpenCreator', function()
    StartCreator()
end)

RegisterNetEvent('redemrp_skin:LoadSkinClient')
AddEventHandler('redemrp_skin:LoadSkinClient', function()
    TriggerServerEvent("RedEM:server:LoadSkin")
end)

RegisterCommand('loadskin', function(source, args, raw)
    TriggerServerEvent("RedEM:server:LoadSkin", true)
end)

function StartCreator()
    TriggerServerEvent("rdr_creator:SetPlayerBucket" , BucketId)
    Wait(500)
    -- while not NetworkIsSessionStarted() do
    --     Wait(0)
    -- end
    for i, m in pairs(overlay_all_layers) do
        overlay_all_layers[i] = {
            name = m.name,
            visibility = 0,
            tx_id = 1,
            tx_normal = 0,
            tx_material = 0,
            tx_color_type = 0,
            tx_opacity = 1.0,
            tx_unk = 0,
            palette = 0,
            palette_color_primary = 0,
            palette_color_secondary = 0,
            palette_color_tertiary = 0,
            var = 0,
            opacity = 0.0
        }
    end
    -- NetworkStartSoloTutorialSession()
    MenuData.CloseAll()
    SpawnedPeds = SpawnPeds()
    local selectedSex = StartSelectCam()
    CreatorCache["sex"] = selectedSex
    local model = GetPedModel(selectedSex)
    LoadModel(PlayerPedId(), model)
    FixIssues(PlayerPedId())
    -- ClonePedToTarget(SpawnedPeds[selectedSex],  PlayerPedId())
    DeletePeds(SpawnedPeds)
    MainMenu()

end

function MainMenu()
    MenuData.CloseAll()
    local elements = {{
        label = "身體",
        value = 'body',
        desc = "編輯身體"
    }, {
        label = "面部",
        value = 'face',
        desc = "編輯面部"
    }, {
        label = "頭髮/鬍鬚",
        value = 'hair',
        desc = "編輯頭髮/鬍鬚"
    }, {
        label = "妝容",
        value = 'makeup',
        desc = "編輯妝容"
    }, {
        label = "保存",
        value = 'save',
        desc = "保存你的角色"
    }}

    MenuData.Open('default', GetCurrentResourceName(), 'main_character_creator_menu', {
        title = '基本外觀',
        subtext = '設置',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        MainMenus[data.current.value]()
    end, function(data, menu)
    end)
end

function OpenBodyMenu()
    MenuData.CloseAll()
    local BodySizeOptions = {"Skinny", "Athletic", "Average", "Heavy", "Burly"}
    local BodyWaistOptions = {}
    for i, v in ipairs(WAIST_TYPES) do
        table.insert(BodyWaistOptions, "+ " .. (i / 2) .. " kg")
    end

    local HeightOptions = {}
    for i=88,106 do
        table.insert(HeightOptions, i.."")
    end
    local SkinToneOptions = {"<img src='nui://redemrp_creator/img/skin1.png' height='20'>",
                             "<img src='nui://redemrp_creator/img/skin2.png' height='20'>",
                             "<img src='nui://redemrp_creator/img/skin3.png' height='20'>",
                             "<img src='nui://redemrp_creator/img/skin4.png' height='20'>",
                             "<img src='nui://redemrp_creator/img/skin5.png' height='20'>",
                             "<img src='nui://redemrp_creator/img/skin6.png' height='20'>"}
    local elements = {{
        label = "面部",
        value = CreatorCache["head"] or 1,
        category = "head",
        desc = "調整的面部",
        type = "slider",
        min = 1,
        max = 120,
        hop = 6
    }, {
        label = "臉型寬度",
        value = CreatorCache["face_width"] or 0,
        category = "face_width",
        desc = "調整臉型寬度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "膚色",
        value = CreatorCache["skin_tone"] or 1,
        category = "skin_tone",
        desc = "調整膚色",
        type = "slider",
        min = 1,
        max = 6,
        options = SkinToneOptions
    }, {
        label = "身型",
        value = CreatorCache["body_size"] or 3,
        category = "body_size",
        desc = "調整你的身型",
        type = "slider",
        min = 1,
        max = 5,
        options = BodySizeOptions
    }, {
        label = "腰圍",
        value = CreatorCache["body_waist"] or 7,
        category = "body_waist",
        desc = "調整腰圍",
        type = "slider",
        min = 1,
        max = 21,
        options = BodyWaistOptions
    }, {
        label = "身高",
        value = CreatorCache["height"] or 94,
        category = "height",
        desc = "調整身高",
        type = "slider",
        min = 88,
        max = 106,
        options = HeightOptions
    }}

    MenuData.Open('default', GetCurrentResourceName(), 'body_character_creator_menu', {
        title = '基本外觀',
        subtext = '設置',
        align = 'top-left',
        elements = elements
    }, function(data, menu)

    end, function(data, menu)
        MainMenu()
    end, function(data, menu)
        if CreatorCache[data.current.category] ~= data.current.value then
            CreatorCache[data.current.category] = data.current.value
            BodyFunctions[data.current.category](PlayerPedId(), CreatorCache)
        end
    end)
end

function OpenFaceMenu()
    MoveCharacterCreatorCamera(-558.97, -3780.95, 239.18)
    MenuData.CloseAll()
    local elements = {{
        label = "眼睛",
        value = 'eyes',
        desc = "編輯眼睛"
    }, {
        label = "眼皮",
        value = 'eyelids',
        desc = "編輯眼皮"
    }, {
        label = "眉毛",
        value = 'eyebrows',
        desc = "編輯眉毛"
    }, {
        label = "鼻",
        value = 'nose',
        desc = "編輯鼻形"
    }, {
        label = "嘴",
        value = 'mouth',
        desc = "編輯嘴型"
    }, {
        label = "顴骨",
        value = 'cheekbones',
        desc = "編輯顴骨"
    }, {
        label = "下顎",
        value = 'jaw',
        desc = "編輯下顎"
    }, {
        label = "耳",
        value = 'ears',
        desc = "編輯耳朵"
    }, {
        label = "下巴",
        value = 'chin',
        desc = "編輯下巴"
    }, {
        label = "臉部瑕疵",
        value = 'defects',
        desc = "編輯臉部瑕疵"
    }}


    MenuData.Open('default', GetCurrentResourceName(), 'face_main_character_creator_menu', {
        title = '臉部特征',
        subtext = '設置',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        FaceFunctions[data.current.value]()
    end, function(data, menu)
        MoveCharacterCreatorCamera(-560.133, -3780.92, 238.6)
        MainMenu()
    end)
end
RegisterNetEvent("rdr_creator:client:HairMenu", function(cb)
    OpenHairMenu2(cb)
end)

function OpenHairMenu2(cb)
    MenuData.CloseAll()
    local elements = {}
    if IsPedMale(PlayerPedId()) then
            local a = 1
            local category = hairs_list["male"]["hair"]
            -- print(CreatorCache["hair"])
            -- print(CreatorCache["beard"])
            if CreatorCache["hair"] == nil or type(CreatorCache["hair"]) ~= "table" then
                CreatorCache["hair"] = {}
                CreatorCache["hair"].model = 0
                CreatorCache["hair"].texture = 1
            end
            if CreatorCache["beard"] == nil or type(CreatorCache["beard"]) ~= "table" then
                CreatorCache["beard"] = {}
                -- print(CreatorCache["beard"])
                CreatorCache["beard"].model = 0
                -- print(CreatorCache["beard"])
                CreatorCache["beard"].texture = 1

            end
            local options = {}
            for k, v in pairs(category) do
                table.insert(options, "Styl " .. k)
            end
            table.insert(elements, {
                label = "髮型",
                value = CreatorCache["hair"].model or 0,
                category = "hair",
                desc = "調整髮型",
                type = "slider",
                min = 0,
                max = #category,
                change_type = "model",
                id = a,
                options = options
            })
            a = a + 1
            options = {}

            for i = 1, GetMaxTexturesForModel("hair", CreatorCache["hair"].model or 1), 1 do
                table.insert(options, "Kolor " .. i)
            end
            table.insert(elements, {
                label = "頭髮顏色",
                value = CreatorCache["hair"].texture or 1,
                category = "hair",
                desc = "調整頭髮顏色",
                type = "slider",
                min = 1,
                max = GetMaxTexturesForModel("hair", CreatorCache["hair"].model or 1),
                change_type = "texture",
                id = a,
                options = options
            })

            options = {}
            a = a + 1


            local category = hairs_list["male"]["beard"]
            for k, v in pairs(category) do
                table.insert(options, "Styl " .. k)
            end
            table.insert(elements, {
                label = "鬍鬚",
                value = CreatorCache["beard"].model or 0,
                category = "beard",
                desc = "調整鬍鬚",
                type = "slider",
                min = 0,
                max = #category,
                change_type = "model",
                id = a,
                options = options
            })
            a = a + 1
            options = {}

            for i = 1, GetMaxTexturesForModel("beard", CreatorCache["beard"].model or 1), 1 do
                table.insert(options, "Color " .. i)
            end
            table.insert(elements, {
                label = "鬍鬚顏色",
                value = CreatorCache["beard"].texture or 1,
                category = "beard",
                desc = "調整鬍鬚顏色",
                type = "slider",
                min = 1,
                max = GetMaxTexturesForModel("beard", CreatorCache["beard"].model or 1),
                change_type = "texture",
                id = a,
                options = options
            })

            options = {}
            a = a + 1
    else
        local a = 1
        local category = hairs_list["female"]["hair"]
        if CreatorCache["hair"] == nil or type(CreatorCache["hair"]) ~= "table" then
            CreatorCache["hair"] = {}
            CreatorCache["hair"].model = 0
            CreatorCache["hair"].texture = 1
        end
        local options = {}
        for k, v in pairs(category) do
            table.insert(options, k .. " Style")
        end
        table.insert(elements, {
            label = "髮型",
            value = CreatorCache["hair"].model or 0,
            category = "hair",
            desc = "調整髮型",
            type = "slider",
            min = 0,
            max = #category,
            change_type = "model",
            id = a,
            options = options
        })
        a = a + 1
        options = {}

        for i = 1, GetMaxTexturesForModel("hair", CreatorCache["hair"].model or 1), 1 do
            table.insert(options, i .. " Color")
        end
        table.insert(elements, {
            label = "頭髮顏色",
            value = CreatorCache["hair"].texture or 1,
            category = "hair",
            desc = "調整頭髮",
            type = "slider",
            min = 1,
            max = GetMaxTexturesForModel("hair", CreatorCache["hair"].model or 1),
            change_type = "texture",
            id = a,
            options = options
        })

        options = {}
        a = a + 1
    end

    table.insert(elements,{
        label = "保存",
        value = "save",
        desc = "保存變更的設置",
    })
    MenuData.Open('default', GetCurrentResourceName(), 'hair_main_character_creator_menu2', {
        title = '髮型',
        subtext = '設置',
        align = 'top-left',
        elements = elements
    }, function(data, menu)

        if data.current.value == "save" then
            MenuData.CloseAll()
            LoadedComponents = CreatorCache
            TriggerServerEvent("rdr_creator:SaveHair", CreatorCache.hair, CreatorCache.beard)
            Wait(500)
            ExecuteCommand("loadskin")
            cb()
        end
    end, function(data, menu)
        MenuData.CloseAll()
        ExecuteCommand("loadskin")
        cb()
    end, function(data, menu)
        if data.current.change_type == "model" then
            if CreatorCache[data.current.category].model ~= data.current.value then
                CreatorCache[data.current.category].texture = 1
                CreatorCache[data.current.category].model = data.current.value
                if data.current.value > 0 then
                    local options = {}
                    -- print(GetMaxTexturesForModel(data.current.category, data.current.value))
                    if GetMaxTexturesForModel(data.current.category, data.current.value) > 1 then
                        for i = 1, GetMaxTexturesForModel(data.current.category, data.current.value), 1 do
                            table.insert(options, "Color " .. i)
                        end
                    else
                        table.insert(options, "None")

                    end
                    menu.setElement(data.current.id + 1, "options", options)
                    menu.setElement(data.current.id + 1, "max",
                        GetMaxTexturesForModel(data.current.category, data.current.value))
                    menu.setElement(data.current.id + 1, "min", 1)
                    menu.setElement(data.current.id + 1, "value", 1)
                    menu.refresh()

                else
                    menu.setElement(data.current.id + 1, "max", 0)
                    menu.setElement(data.current.id + 1, "min", 0)
                    menu.setElement(data.current.id + 1, "value", 0)
                    menu.refresh()

                end
                HairFunctions[data.current.category](PlayerPedId(), CreatorCache)
            end
         elseif data.current.change_type == "texture" then
            -- print(CreatorCache[data.current.category].texture)
            if CreatorCache[data.current.category].texture ~= data.current.value then
                CreatorCache[data.current.category].texture = data.current.value
                HairFunctions[data.current.category](PlayerPedId(), CreatorCache)
            end
        else
            if CreatorCache[data.current.category] ~= data.current.value then
                CreatorCache[data.current.category] = data.current.value
                HairFunctions[data.current.category](PlayerPedId(), CreatorCache)
            end
        end
    end)
end


function OpenHairMenu()
    MoveCharacterCreatorCamera(-558.97, -3780.95, 239.18)
    MenuData.CloseAll()
    local elements = {}
    if IsPedMale(PlayerPedId()) then
            local a = 1
            local category = hairs_list["male"]["hair"]
            -- print(CreatorCache["hair"])
            -- print(CreatorCache["beard"])
            if CreatorCache["hair"] == nil or type(CreatorCache["hair"]) ~= "table" then
                CreatorCache["hair"] = {}
                CreatorCache["hair"].model = 0
                CreatorCache["hair"].texture = 1
            end
            if CreatorCache["beard"] == nil or type(CreatorCache["beard"]) ~= "table" then
                CreatorCache["beard"] = {}
                -- print(CreatorCache["beard"])
                CreatorCache["beard"].model = 0
                -- print(CreatorCache["beard"])
                CreatorCache["beard"].texture = 1

            end
            local options = {}
            for k, v in pairs(category) do
                table.insert(options, "Styl " .. k)
            end
            table.insert(elements, {
                label = "髮型",
                value = CreatorCache["hair"].model or 0,
                category = "hair",
                desc = "調整髮型",
                type = "slider",
                min = 0,
                max = #category,
                change_type = "model",
                id = a,
                options = options
            })
            a = a + 1
            options = {}

            for i = 1, GetMaxTexturesForModel("hair", CreatorCache["hair"].model or 1), 1 do
                table.insert(options,i.." Color")
            end
            table.insert(elements, {
                label = "頭髮顏色",
                value = CreatorCache["hair"].texture or 1,
                category = "hair",
                desc = "調整頭髮顏色",
                type = "slider",
                min = 1,
                max = GetMaxTexturesForModel("hair", CreatorCache["hair"].model or 1),
                change_type = "texture",
                id = a,
                options = options
            })

            options = {}
            a = a + 1


            local category = hairs_list["male"]["beard"]
            for k, v in pairs(category) do
                table.insert(options, k.." Style")
            end
            table.insert(elements, {
                label = "鬍鬚",
                value = CreatorCache["beard"].model or 0,
                category = "beard",
                desc = "調整鬍鬚類型",
                type = "slider",
                min = 0,
                max = #category,
                change_type = "model",
                id = a,
                options = options
            })
            a = a + 1
            options = {}

            for i = 1, GetMaxTexturesForModel("beard", CreatorCache["beard"].model or 1), 1 do
                table.insert(options, "Color " .. i)
            end
            table.insert(elements, {
                label = "鬍鬚顏色",
                value = CreatorCache["beard"].texture or 1,
                category = "beard",
                desc = "調整鬍鬚顏色",
                type = "slider",
                min = 1,
                max = GetMaxTexturesForModel("beard", CreatorCache["beard"].model or 1),
                change_type = "texture",
                id = a,
                options = options
            })

            options = {}
            a = a + 1
    else
        local a = 1
        local category = hairs_list["female"]["hair"]
        if CreatorCache["hair"] == nil or type(CreatorCache["hair"]) ~= "table" then
            CreatorCache["hair"] = {}
            CreatorCache["hair"].model = 0
            CreatorCache["hair"].texture = 1
        end
        local options = {}
        for k, v in pairs(category) do
            table.insert(options, "Styl " .. k)
        end
        table.insert(elements, {
            label = "髮型",
            value = CreatorCache["hair"].model or 0,
            category = "hair",
            desc = "調整髮型",
            type = "slider",
            min = 0,
            max = #category,
            change_type = "model",
            id = a,
            options = options
        })
        a = a + 1
        options = {}

        for i = 1, GetMaxTexturesForModel("hair", CreatorCache["hair"].model or 1), 1 do
            table.insert(options, "Kolor " .. i)
        end
        table.insert(elements, {
            label = "頭髮顏色",
            value = CreatorCache["hair"].texture or 1,
            category = "hair",
            desc = "調整頭髮顏色",
            type = "slider",
            min = 1,
            max = GetMaxTexturesForModel("hair", CreatorCache["hair"].model or 1),
            change_type = "texture",
            id = a,
            options = options
        })

        options = {}
        a = a + 1
    end
    MenuData.Open('default', GetCurrentResourceName(), 'hair_main_character_creator_menu', {
        title = '髮型',
        subtext = '設置',
        align = 'top-left',
        elements = elements
    }, function(data, menu)

    end, function(data, menu)
        MoveCharacterCreatorCamera(-560.133, -3780.92, 238.6)
        MainMenu()
    end, function(data, menu)


        if data.current.change_type == "model" then
            if CreatorCache[data.current.category].model ~= data.current.value then
                CreatorCache[data.current.category].texture = 1
                CreatorCache[data.current.category].model = data.current.value
                if data.current.value > 0 then
                    local options = {}
                    -- print(GetMaxTexturesForModel(data.current.category, data.current.value))
                    if GetMaxTexturesForModel(data.current.category, data.current.value) > 1 then
                        for i = 1, GetMaxTexturesForModel(data.current.category, data.current.value), 1 do
                            table.insert(options, "Color " .. i)
                        end
                    else
                        table.insert(options, "None")

                    end
                    menu.setElement(data.current.id + 1, "options", options)
                    menu.setElement(data.current.id + 1, "max",
                        GetMaxTexturesForModel(data.current.category, data.current.value))
                    menu.setElement(data.current.id + 1, "min", 1)
                    menu.setElement(data.current.id + 1, "value", 1)
                    menu.refresh()

                else
                    menu.setElement(data.current.id + 1, "max", 0)
                    menu.setElement(data.current.id + 1, "min", 0)
                    menu.setElement(data.current.id + 1, "value", 0)
                    menu.refresh()

                end
                HairFunctions[data.current.category](PlayerPedId(), CreatorCache)
            end
         elseif data.current.change_type == "texture" then
            -- print(CreatorCache[data.current.category].texture)
            if CreatorCache[data.current.category].texture ~= data.current.value then
                CreatorCache[data.current.category].texture = data.current.value
                HairFunctions[data.current.category](PlayerPedId(), CreatorCache)
            end
        else
            if CreatorCache[data.current.category] ~= data.current.value then
                CreatorCache[data.current.category] = data.current.value
                HairFunctions[data.current.category](PlayerPedId(), CreatorCache)
            end
        end
    end)
end

function OpenEyesMenu()
    MenuData.CloseAll()
    local EyesColorOptions = {"<img src='nui://redemrp_creator/img/skin1.png' height='20'>",
                              "<img src='nui://redemrp_creator/img/skin2.png' height='20'>",
                              "<img src='nui://redemrp_creator/img/skin3.png' height='20'>",
                              "<img src='nui://redemrp_creator/img/skin4.png' height='20'>",
                              "<img src='nui://redemrp_creator/img/skin5.png' height='20'>",
                              "<img src='nui://redemrp_creator/img/skin6.png' height='20'>"}
    local elements = {{
        label = "眼睛顏色",
        value = CreatorCache["eyes_color"] or 1,
        category = "eyes_color",
        desc = "調整眼睛顏色",
        type = "slider",
        min = 1,
        max = 18
    }, {
        label = "眼睛深度",
        value = CreatorCache["eyes_depth"] or 0,
        category = "eyes_depth",
        desc = "調整眼睛深度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "眼睛角度",
        value = CreatorCache["eyes_angle"] or 0,
        category = "eyes_angle",
        desc = "調整眼睛角度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "瞳距",
        value = CreatorCache["eyes_distance"] or 0,
        category = "eyes_distance",
        desc = "調整瞳距",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }}

    MenuData.Open('default', GetCurrentResourceName(), 'eyes_character_creator_menu', {
        title = '眼睛',
        subtext = '設置',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
    end, function(data, menu)
        OpenFaceMenu()
    end, function(data, menu)
        if CreatorCache[data.current.category] ~= data.current.value then
            CreatorCache[data.current.category] = data.current.value
            EyesFunctions[data.current.category](PlayerPedId(), CreatorCache)
        end
    end)
end

function OpenEyelidsMenu()
    MenuData.CloseAll()
    local elements = {{
        label = "眼瞼高度",
        value = CreatorCache["eyelid_height"] or 0,
        category = "eyelid_height",
        desc = "調整眼瞼高度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "眼瞼寬度",
        value = CreatorCache["eyelid_width"] or 0,
        category = "eyelid_width",
        desc = "調整眼瞼寬度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }}

    MenuData.Open('default', GetCurrentResourceName(), 'eyelid_character_creator_menu', {
        title = '眼瞼',
        subtext = '設置',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
    end, function(data, menu)
        OpenFaceMenu()
    end, function(data, menu)
        if CreatorCache[data.current.category] ~= data.current.value then
            CreatorCache[data.current.category] = data.current.value
            EyelidsFunctions[data.current.category](PlayerPedId(), CreatorCache)
        end
    end)
end

function OpenEyebrowsMenu()
    MenuData.CloseAll()
    local elements = {{
        label = "眉毛高度",
        value = CreatorCache["eyebrow_height"] or 0,
        category = "eyebrow_height",
        desc = "調整眉毛高度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "眉毛寬度",
        value = CreatorCache["eyebrow_width"] or 0,
        category = "eyebrow_width",
        desc = "調整眉毛寬度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "眉毛深度",
        value = CreatorCache["eyebrow_depth"] or 0,
        category = "eyebrow_depth",
        desc = "調整眉毛深度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "眉毛類型",
        value = CreatorCache["eyebrows_t"] or 1,
        category = "eyebrows_t",
        desc = "調整眉毛類型",
        type = "slider",
        min = 1,
        max = 15
    }, {
        label = "眉毛可見度",
        value = CreatorCache["eyebrows_op"] or 100,
        category = "eyebrows_op",
        desc = "調整眉毛可見度",
        type = "slider",
        min = 0,
        max = 100,
        hop = 5
    }, {
        label = "眉毛顏色",
        value = CreatorCache["eyebrows_id"] or 10,
        category = "eyebrows_id",
        desc = "調整眉毛顏色",
        type = "slider",
        min = 1,
        max = 25
    }, {
        label = "眉毛主要顏色",
        value = CreatorCache["eyebrows_c1"] or 0,
        category = "eyebrows_c1",
        desc = "調整眉毛主要顏色",
        type = "slider",
        min = 0,
        max = 64
    }}

    MenuData.Open('default', GetCurrentResourceName(), 'eyebrows_character_creator_menu', {
        title = '眉毛',
        subtext = '設置',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
    end, function(data, menu)
        OpenFaceMenu()
    end, function(data, menu)
        if CreatorCache[data.current.category] ~= data.current.value then
            CreatorCache[data.current.category] = data.current.value
            EyebrowsFunctions[data.current.category](PlayerPedId(), CreatorCache)
        end
    end)
end

function OpenNoseMenu()
    MenuData.CloseAll()
    local elements = {{
        label = "鼻型寬度",
        value = CreatorCache["nose_width"] or 0,
        category = "nose_width",
        desc = "調整鼻型寬度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "鼻型尺寸",
        value = CreatorCache["nose_size"] or 0,
        category = "nose_size",
        desc = "調整鼻型尺寸",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "鼻型高度",
        value = CreatorCache["nose_height"] or 0,
        category = "nose_height",
        desc = "調整鼻型高度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "鼻型角度",
        value = CreatorCache["nose_angle"] or 0,
        category = "nose_angle",
        desc = "調整鼻型角度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "鼻型彎曲",
        value = CreatorCache["nose_curvature"] or 0,
        category = "nose_curvature",
        desc = "調整鼻型彎曲",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "鼻孔距離",
        value = CreatorCache["nostrils_distance"] or 0,
        category = "nostrils_distance",
        desc = "調整鼻孔距離",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }}

    MenuData.Open('default', GetCurrentResourceName(), 'nose_character_creator_menu', {
        title = '鼻型',
        subtext = '設置',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
    end, function(data, menu)
        OpenFaceMenu()
    end, function(data, menu)
        if CreatorCache[data.current.category] ~= data.current.value then
            CreatorCache[data.current.category] = data.current.value
            LoadFeatures(PlayerPedId(), CreatorCache)
        end
    end)
end

function OpenMouthMenu()
    MenuData.CloseAll()
    local elements = {{
        label = "嘴型寬度",
        value = CreatorCache["mouth_width"] or 0,
        category = "mouth_width",
        desc = "調整嘴型寬度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "嘴型深度",
        value = CreatorCache["mouth_depth"] or 0,
        category = "mouth_depth",
        desc = "調整嘴型深度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "嘴型上下位置",
        value = CreatorCache["mouth_x_pos"] or 0,
        category = "mouth_x_pos",
        desc = "調整嘴型上下位置",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "嘴型左右位置",
        value = CreatorCache["mouth_y_pos"] or 0,
        category = "mouth_y_pos",
        desc = "調整嘴型左右位置",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "上唇高度",
        value = CreatorCache["upper_lip_height"] or 0,
        category = "upper_lip_height",
        desc = "調整上唇高度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "上唇高度",
        value = CreatorCache["upper_lip_width"] or 0,
        category = "upper_lip_width",
        desc = "調整上唇高度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "上唇深度",
        value = CreatorCache["upper_lip_depth"] or 0,
        category = "upper_lip_depth",
        desc = "調整上唇深度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "下唇高度",
        value = CreatorCache["lower_lip_height"] or 0,
        category = "lower_lip_height",
        desc = "調整下唇高度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "下唇寬度",
        value = CreatorCache["lower_lip_width"] or 0,
        category = "lower_lip_width",
        desc = "調整下唇寬度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "下唇深度",
        value = CreatorCache["lower_lip_depth"] or 0,
        category = "lower_lip_depth",
        desc = "調整下唇深度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }}

    MenuData.Open('default', GetCurrentResourceName(), 'mouth_character_creator_menu', {
        title = '嘴型',
        subtext = '設置',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
    end, function(data, menu)
        OpenFaceMenu()
    end, function(data, menu)
        if CreatorCache[data.current.category] ~= data.current.value then
            CreatorCache[data.current.category] = data.current.value
            LoadFeatures(PlayerPedId(), CreatorCache)
        end
    end)
end

function OpenCheekbonesMenu()
    MenuData.CloseAll()
    local elements = {{
        label = "顴骨高度",
        value = CreatorCache["cheekbones_height"] or 0,
        category = "cheekbones_height",
        desc = "調整顴骨高度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "顴骨寬度",
        value = CreatorCache["cheekbones_width"] or 0,
        category = "cheekbones_width",
        desc = "調整顴骨寬度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "顴骨深度",
        value = CreatorCache["cheekbones_depth"] or 0,
        category = "cheekbones_depth",
        desc = "改變顴骨深度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }}

    MenuData.Open('default', GetCurrentResourceName(), 'cheekbones_character_creator_menu', {
        title = '顴骨',
        subtext = '設置',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
    end, function(data, menu)
        OpenFaceMenu()
    end, function(data, menu)
        if CreatorCache[data.current.category] ~= data.current.value then
            CreatorCache[data.current.category] = data.current.value
            LoadFeatures(PlayerPedId(), CreatorCache)
        end
    end)
end

function OpenJawMenu()
    MenuData.CloseAll()
    local elements = {{
        label = "下顎高度",
        value = CreatorCache["jaw_height"] or 0,
        category = "jaw_height",
        desc = "調整下顎高度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "下顎寬度",
        value = CreatorCache["jaw_width"] or 0,
        category = "jaw_width",
        desc = "調整下顎寬度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "下顎深度",
        value = CreatorCache["jaw_depth"] or 0,
        category = "jaw_depth",
        desc = "調整下顎深度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }}

    MenuData.Open('default', GetCurrentResourceName(), 'jaw_character_creator_menu', {
        title = '下顎',
        subtext = '設置',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
    end, function(data, menu)
        OpenFaceMenu()
    end, function(data, menu)
        if CreatorCache[data.current.category] ~= data.current.value then
            CreatorCache[data.current.category] = data.current.value
            LoadFeatures(PlayerPedId(), CreatorCache)
        end
    end)
end

function OpenEarsMenu()
    MenuData.CloseAll()
    local elements = {{
        label = "耳朵寬度",
        value = CreatorCache["ears_width"] or 0,
        category = "ears_width",
        desc = "調整耳朵寬度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "耳朵角度",
        value = CreatorCache["ears_angle"] or 0,
        category = "ears_angle",
        desc = "調整耳朵角度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "耳朵高度",
        value = CreatorCache["ears_height"] or 0,
        category = "ears_height",
        desc = "調整耳朵寬度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "耳朵尺寸",
        value = CreatorCache["earlobe_size"] or 0,
        category = "earlobe_size",
        desc = "調整耳朵尺寸",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }}

    MenuData.Open('default', GetCurrentResourceName(), 'ears_character_creator_menu', {
        title = '耳朵',
        subtext = '設置',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
    end, function(data, menu)
        OpenFaceMenu()
    end, function(data, menu)
        if CreatorCache[data.current.category] ~= data.current.value then
            CreatorCache[data.current.category] = data.current.value
            LoadFeatures(PlayerPedId(), CreatorCache)
        end
    end)
end

function OpenChinMenu()
    MenuData.CloseAll()
    local elements = {{
        label = "下巴高度",
        value = CreatorCache["chin_height"] or 0,
        category = "chin_height",
        desc = "調整下巴高度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "下巴寬度",
        value = CreatorCache["chin_width"] or 0,
        category = "chin_width",
        desc = "調整下巴寬度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }, {
        label = "下巴深度",
        value = CreatorCache["chin_depth"] or 0,
        category = "chin_depth",
        desc = "調整下巴深度",
        type = "slider",
        min = -100,
        max = 100,
        hop = 5
    }}

    MenuData.Open('default', GetCurrentResourceName(), 'chin_character_creator_menu', {
        title = '下巴',
        subtext = '設置',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
    end, function(data, menu)
        OpenFaceMenu()
    end, function(data, menu)
        if CreatorCache[data.current.category] ~= data.current.value then
            CreatorCache[data.current.category] = data.current.value
            LoadFeatures(PlayerPedId(), CreatorCache)
        end
    end)
end

function OpenDefectsMenu()
    MenuData.CloseAll()
    local elements = {{
        label = "傷痕特征",
        value = CreatorCache["scars_t"] or 1,
        category = "scars_t",
        desc = "調整傷痕特征",
        type = "slider",
        min = 1,
        max = 16,
        options = nil
    }, {
        label = "傷痕可見度",
        value = CreatorCache["scars_op"] or 0,
        category = "scars_op",
        desc = "調整傷痕可見度",
        type = "slider",
        min = 0,
        max = 100,
        hop = 5
    }, {
        label = "老化特征",
        value = CreatorCache["ageing_t"] or 1,
        category = "ageing_t",
        desc = "調整老化特征",
        type = "slider",
        min = 1,
        max = 24,
        options = nil
    }, {
        label = "老化可見度",
        value = CreatorCache["ageing_op"] or 0,
        category = "ageing_op",
        desc = "調整老化可見度",
        type = "slider",
        min = 0,
        max = 100,
        hop = 5
    }, {
        label = "雀斑特征",
        value = CreatorCache["freckles_t"] or 1,
        category = "freckles_t",
        desc = "調整雀斑特征",
        type = "slider",
        min = 1,
        max = 15,
        options = nil
    }, {
        label = "雀斑可見度",
        value = CreatorCache["freckles_op"] or 0,
        category = "freckles_op",
        desc = "調整雀斑可見度",
        type = "slider",
        min = 0,
        max = 100,
        hop = 5
    }, {
        label = "痣癦",
        value = CreatorCache["moles_t"] or 1,
        category = "moles_t",
        desc = "調整痣癦",
        type = "slider",
        min = 1,
        max = 16,
        options = nil
    }, {
        label = "痣癦可見度",
        value = CreatorCache["moles_op"] or 0,
        category = "moles_op",
        desc = "調整痣癦可見度",
        type = "slider",
        min = 0,
        max = 100,
        hop = 5
    }, {
        label = "斑點特征",
        value = CreatorCache["spots_t"] or 1,
        category = "spots_t",
        desc = "調整斑點特征",
        type = "slider",
        min = 1,
        max = 16,
        options = nil
    }, {
        label = "斑點可見度",
        value = CreatorCache["spots_op"] or 0,
        category = "spots_op",
        desc = "調整斑點可見度",
        type = "slider",
        min = 0,
        max = 100,
        hop = 5
    }}

    MenuData.Open('default', GetCurrentResourceName(), 'defects_character_creator_menu', {
        title = '瑕疵',
        subtext = '設置',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
    end, function(data, menu)
        OpenFaceMenu()
    end, function(data, menu)
        if CreatorCache[data.current.category] ~= data.current.value then
            CreatorCache[data.current.category] = data.current.value
            LoadOverlays(PlayerPedId(), CreatorCache)
        end
    end)
end

function OpenMakeupMenu()
    MoveCharacterCreatorCamera(-558.97, -3780.95, 239.18)
    MenuData.CloseAll()
    local elements = {{
        label = "眼影類型",
        value = CreatorCache["shadows_t"] or 1,
        category = "shadows_t",
        desc = "調整眼影類型",
        type = "slider",
        min = 1,
        max = 5
    }, {
        label = "眼影可見度",
        value = CreatorCache["shadows_op"] or 0,
        category = "shadows_op",
        desc = "調整眼影可見度",
        type = "slider",
        min = 0,
        max = 100,
        hop = 5
    }, {
        label = "眼影顏色",
        value = CreatorCache["shadows_id"] or 1,
        category = "shadows_id",
        desc = "調整眼影顏色",
        type = "slider",
        min = 1,
        max = 25
    }, {
        label = "眼影主要顏色",
        value = CreatorCache["shadows_c1"] or 0,
        category = "shadows_c1",
        desc = "調整眼影主要顏色",
        type = "slider",
        min = 0,
        max = 64
    }, {
        label = "腮紅類型",
        value = CreatorCache["blush_t"] or 1,
        category = "blush_t",
        desc = "調整腮紅類型",
        type = "slider",
        min = 1,
        max = 4
    }, {
        label = "腮紅可見度",
        value = CreatorCache["blush_op"] or 0,
        category = "blush_op",
        desc = "調整腮紅可見度",
        type = "slider",
        min = 0,
        max = 100,
        hop = 5
    }, {
        label = "腮紅顏色",
        value = CreatorCache["blush_id"] or 1,
        category = "blush_id",
        desc = "調整腮紅顏色",
        type = "slider",
        min = 1,
        max = 25
    }, {
        label = "腮紅主要顏色",
        value = CreatorCache["blush_c1"] or 0,
        category = "blush_c1",
        desc = "調整腮紅主要顏色",
        type = "slider",
        min = 0,
        max = 64
    }, {
        label = "口紅特征",
        value = CreatorCache["lipsticks_t"] or 1,
        category = "lipsticks_t",
        desc = "調整口紅特征",
        type = "slider",
        min = 1,
        max = 7
    }, {
        label = "口紅可見度",
        value = CreatorCache["lipsticks_op"] or 0,
        category = "lipsticks_op",
        desc = "調整口紅可見度",
        type = "slider",
        min = 0,
        max = 100,
        hop = 5
    }, {
        label = "口紅顏色",
        value = CreatorCache["lipsticks_id"] or 1,
        category = "lipsticks_id",
        desc = "調整口紅顏色",
        type = "slider",
        min = 1,
        max = 25
    }, {
        label = "口紅主要顏色",
        value = CreatorCache["lipsticks_c1"] or 0,
        category = "lipsticks_c1",
        desc = "調整口紅主要顏色",
        type = "slider",
        min = 0,
        max = 64
    }, {
        label = "口紅次要顏色",
        value = CreatorCache["lipsticks_c2"] or 0,
        category = "lipsticks_c2",
        desc = "調整口紅次要顏色",
        type = "slider",
        min = 0,
        max = 64
    }, {
        label = "眼線類型",
        value = CreatorCache["eyeliners_t"] or 1,
        category = "eyeliners_t",
        desc = "調整眼線類型",
        type = "slider",
        min = 1,
        max = 15
    }, {
        label = "眼線可見度",
        value = CreatorCache["eyeliners_op"] or 0,
        category = "eyeliners_op",
        desc = "調整眼線可見度",
        type = "slider",
        min = 0,
        max = 100,
        hop = 5
    }, {
        label = "眼線顏色",
        value = CreatorCache["eyeliners_id"] or 1,
        category = "eyeliners_id",
        desc = "調整眼線顏色",
        type = "slider",
        min = 1,
        max = 25
    }, {
        label = "眼線主要顏色",
        value = CreatorCache["eyeliners_c1"] or 0,
        category = "eyeliners_c1",
        desc = "調整眼線主要顏色",
        type = "slider",
        min = 0,
        max = 64
    }}

    MenuData.Open('default', GetCurrentResourceName(), 'makeup_character_creator_menu', {
        title = '妝容',
        subtext = '設置',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
    end, function(data, menu)
        MoveCharacterCreatorCamera(-560.133, -3780.92, 238.6)
        MainMenu()
    end, function(data, menu)
        if CreatorCache[data.current.category] ~= data.current.value then
            CreatorCache[data.current.category] = data.current.value
            LoadOverlays(PlayerPedId(), CreatorCache)
        end
    end)
end

exports('GetComponentId', function(name)
    return LoadedComponents[name]
end)

exports('GetBodyComponents', function()
    return {ComponentsMale, ComponentsFemale}
end)

exports('GetBodyCurrentComponentHash', function(name)
    local hash
    if name == "hair" or name == "beard" then
        local info = LoadedComponents[name]
        local texture = info.texture
        local model = info.model
        if model == 0 or texture == 0 then
            return
        end
        if type(info) == "table" then
            if IsPedMale(PlayerPedId()) then
                if hairs_list["male"][name][model][texture] ~= nil then
                    hash = hairs_list["male"][name][model][texture].hash
                end
            else
                if hairs_list["female"][name][model][texture] ~= nil then
                    hash = hairs_list["female"][name][model][texture].hash
                end
            end
        end
        return hash
    else

        local id = LoadedComponents[name]

        if not id then
            return
        end
        if IsPedMale(PlayerPedId()) then
            if ComponentsMale[name] ~= nil then
                hash = ComponentsMale[name][id]
            end
        else
            if ComponentsFemale[name] ~= nil then
                hash = ComponentsFemale[name][id]
            end
        end
        return hash
    end
end)


exports('SetFaceOverlays', function(target, data)
    LoadOverlays(target, data)
end)

exports('SetHair', function(target, data)
    LoadHair(target, data)
end)

exports('SetBeard', function(target, data)
    LoadBeard(target, data)
end)

exports('GetComponentsMax', function(name)
    if name == "hair" or name == "beard" then
        if IsPedMale(PlayerPedId()) then
            if hairs_list["male"][name] ~= nil then
                return #hairs_list["male"][name]
            end
        else
            if hairs_list["female"][name] ~= nil then
                return #hairs_list["female"][name]
            end
        end
    else
        if IsPedMale(PlayerPedId()) then
            if ComponentsMale[name] ~= nil then
                return #ComponentsMale[name]
            end
        else
            if ComponentsFemale[name] ~= nil then
                return #ComponentsFemale[name]
            end
        end
    end
end)

exports('GetMaxTexturesForModel', function(category , model)
    return GetMaxTexturesForModel(category,model)
end)