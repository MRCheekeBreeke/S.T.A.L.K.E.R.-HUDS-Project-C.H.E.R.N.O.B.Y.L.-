--#Shadow of Chernobyl

--HUD Init
if CLIENT then
        
    --Painting HUD
    hook.Add("HUDPaint", "stalk_soc_interface", function()

        --If ConVar not is "soc", off style
        if GetConVar( "stalk_hud_style" ):GetString() == "soc" and GetConVar( "stalk_hud_toggle" ):GetInt() == 1 and LocalPlayer():Alive() then

            --surface.SetMaterial( Material( "mrcb_mods/huds/soc/podgon.png" ) )
            --surface.SetDrawColor( 255, 255, 255, 150 )
            --surface.DrawTexturedRect( 0, 0, 1366, 768 )

                --Ammo panel
            surface.SetMaterial( Material( "mrcb_mods/huds/soc/ui_ammo.png" ) )
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.DrawTexturedRect( ScrW() - 166, ScrH() - 76, 163, 66 )

            surface.SetTextPos(ScrW() - 120, ScrH() - 77)
            surface.SetFont("Trebuchet18")
            surface.SetTextColor(163,163,163)
            surface.DrawText(stalk_ply_ammoname)

            surface.SetTextPos(ScrW() - 62, ScrH() - 51)
            surface.SetFont("HudHintTextLarge")
            surface.SetTextColor(255,123,0)
            if stalk_ply_clipcount != " " then

                surface.DrawText(tostring(stalk_ply_clipcount .. "/" .. stalk_ply_ammocount))

            else

                surface.DrawText(stalk_ply_ammocount)
                
            end

            stalk_drawammo( 120, 40, 1)

                --Health and armor panel
            surface.SetMaterial( Material( "mrcb_mods/huds/soc/ui_bars.png" ) )
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.DrawTexturedRect( ScrW() - 165, ScrH() - 143, 163, 69 )

                --Health bar
            surface.SetMaterial( Material( "mrcb_mods/huds/soc/ui_health.png" ) )
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.DrawPartialTexturedRect( ScrW() - 133, ScrH() - 100, 110 * (stalk_ply_health * 0.01), 10, 0, 0, 110 * (stalk_ply_health * 0.01), 10, 110, 10)

                --Armor bar
            surface.SetMaterial( Material( "mrcb_mods/huds/soc/ui_armor.png" ) )
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.DrawPartialTexturedRect( ScrW() - 133, ScrH() - 119, 110 * (stalk_ply_armor * 0.01), 10, 0, 0, 110 * (stalk_ply_armor * 0.01), 10, 110, 10)

                --Radar/Minimap
            surface.SetMaterial( Material( "mrcb_mods/huds/soc/ui_radar.png" ) )
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.DrawTexturedRect( 9, 3, 185, 191 )

                --Targets Display
            for i = 1, #stalk_ply_targets_radared do

                local xpos = (stalk_ply_targets_radared[i].pos.xpos)  + (3 + 191) / 2
                local ypos = (stalk_ply_targets_radared[i].pos.ypos)  + (9 + 185) / 2

                if (xpos > 20 and xpos < (182)) and (ypos > 20 and ypos < 175) then

                    if IsFriendEntityName(stalk_ply_targets_radared[i].class) then

                        surface.SetDrawColor(0,255,0,255)

                    elseif IsEnemyEntityName(stalk_ply_targets_radared[i].class) then

                        surface.SetDrawColor(255,0,0,255)
                        
                    elseif stalk_ply_targets_radared[i].class == "player" then

                        surface.SetDrawColor(255,255,255,255)

                    elseif stalk_ply_targets_radared[i].class == "prop_ragdoll" then

                        surface.SetDrawColor(182,182,182)
                        
                    else

                        surface.SetDrawColor(255,255,0,255)
                        
                    end

                surface.DrawRect( xpos, ypos, 2, 2)

                end
    
            end

            surface.SetMaterial( Material( "mrcb_mods/huds/soc/ui_counter.png" ) )
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.DrawTexturedRect( 150, 172, 32, 28 )

            local counter = 0

            for i = 1, #stalk_ply_targets_radared do

                if stalk_ply_targets_radared[i].class != "prop_ragdoll" then

                    counter = counter + 1
                    
                end

            end

            if counter > 1 then
            surface.SetTextPos(160, 180)
            surface.SetFont("HudHintTextLarge")
            surface.SetTextColor(255,230,0)
            surface.DrawText(tostring(counter - 1))
            end

                --Player Status Panel
            surface.SetMaterial( Material( "mrcb_mods/huds/soc/ui_stats.png" ) )
            surface.SetDrawColor( 255, 255, 255)
            surface.DrawTexturedRect( 1, ScrH() - 128, 123, 118 )

                --Player Move Check
            if stalk_ply_movetype == "LADDER" then

                surface.SetMaterial( Material( "mrcb_mods/huds/soc/ui_ply_climb.png" ) )
                surface.SetDrawColor( 255, 255, 255)
                surface.DrawTexturedRect( 43, ScrH() - 103, 26, 71 )
                
            elseif stalk_ply_movetype == "CROUCH" then

                surface.SetMaterial( Material( "mrcb_mods/huds/soc/ui_ply_crouch.png" ) )
                surface.SetDrawColor( 255, 255, 255)
                surface.DrawTexturedRect( 35, ScrH() - 80, 53, 40 )

            elseif stalk_ply_movetype == "WALK" then

                surface.SetMaterial( Material( "mrcb_mods/huds/soc/ui_ply_walk.png" ) )
                surface.SetDrawColor( 255, 255, 255)
                surface.DrawTexturedRect( 35, ScrH() - 102, 56, 66 )

            elseif stalk_ply_movetype == "RUN" then

                surface.SetMaterial( Material( "mrcb_mods/huds/soc/ui_ply_run.png" ) )
                surface.SetDrawColor( 255, 255, 255)
                surface.DrawTexturedRect( 37, ScrH() - 102, 39, 69 )

            else
                
                surface.SetMaterial( Material( "mrcb_mods/huds/soc/ui_ply_idle.png" ) )
                surface.SetDrawColor( 255, 255, 255)
                surface.DrawTexturedRect( 43, ScrH() - 103, 32, 68 )

            end

        end

    end)

end