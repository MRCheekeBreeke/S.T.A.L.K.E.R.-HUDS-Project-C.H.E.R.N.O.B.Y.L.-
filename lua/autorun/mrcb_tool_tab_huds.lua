if CLIENT then

    if mrcb_stalk_menu_exist == nil then

        hook.Add( "AddToolMenuTabs", "mrcb_stalk_menu_create", function()
            spawnmenu.AddToolTab( "mrcb_stalk_menu", "S.T.A.L.K.E.R.", "mrcb_mods/all/stalk_menu_logo.png" )
            mrcb_stalk_menu_exist = true
        end)

    end

    spawnmenu.AddToolCategory( mrcb_stalk_menu, "mrcb_stalk_menu_huds", "HUDs" )

    --CLIENT CATEGORY
    hook.Add( "PopulateToolMenu", "mrcb_stalk_menu_huds_init", function()

        spawnmenu.AddToolMenuOption( "mrcb_stalk_menu", "mrcb_stalk_menu_huds", "mrcb_stalk_menu_huds_cl", "Client", "", "", function( panel )

            panel:ClearControls()

            panel:CheckBox( "HUD Toggle", "stalk_hud_toggle")

            --STYLE CHOOSER
            local mrcb_stalk_menu_huds_style = panel:ComboBox( "HUD Style", "stalk_hud_style")

            for k, v in pairs(mrcb_stalk_styles_clfiles) do
                
                mrcb_stalk_menu_huds_style:AddChoice(v,v,nil,"mrcb_mods/all/stalk_menu_logo.png")

            end

        end )

    end )

end