if SERVER then

    AddCSLuaFile("autorun/mrcb_cl_huds.lua")
    AddCSLuaFile("autorun/mrcb_tool_tab_huds.lua")

    local files_stalk = file.Find( "stalk_styles/huds/*", "LUA", "namedesc" )
    mrcb_stalk_styles_svfiles = {}

    PrintTable(files_stalk)
    print("SERVER Styles found: " .. #files_stalk)

    if #files_stalk >= 0 then
        
        for i = 1, #files_stalk do

            mrcb_stalk_styles_svfiles[i] = string.gsub(files_stalk[i], ".lua", "")
            
            print(files_stalk[i] .. " was added on clientside")
            AddCSLuaFile("stalk_styles/huds/" .. files_stalk[i])

        end

    end

end

if CLIENT then

    include("autorun/mrcb_cl_huds.lua")
    include("autorun/mrcb_tool_tab_huds.lua")
    
    local files_stalk = file.Find( "stalk_styles/huds/*", "LUA", "namedesc" )
    mrcb_stalk_styles_clfiles = {}

    PrintTable(files_stalk)
    print("CLIENT Styles found: " .. #files_stalk)

    if #files_stalk >= 0 then
        
        for i = 1, #files_stalk do

            mrcb_stalk_styles_clfiles[i] = string.gsub(files_stalk[i], ".lua", "")
            
            print(files_stalk[i] .. " was included and activated on clientside")
            include("stalk_styles/huds/" .. files_stalk[i])

        end

    end

end