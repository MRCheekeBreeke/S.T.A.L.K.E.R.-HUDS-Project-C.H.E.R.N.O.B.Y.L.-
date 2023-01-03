--#Clear Sky

if CLIENT then
    
    --Painting HUD
    hook.Add("HUDPaint", "stalk_cs_interface", function()

        --If ConVar not is "cs", off style
        if GetConVar( "stalk_hud_style" ):GetString() == "cs" and GetConVar( "stalk_hud_toggle" ):GetInt() == 1 and LocalPlayer():Alive() then

            --surface.SetMaterial( Material( "mrcb_mods/huds/soc/podgon.png" ) )
            --surface.SetDrawColor( 255, 255, 255, 150 )
            --surface.DrawTexturedRect( 0, 0, 1366, 768 )

                --Health and armor panel
            surface.SetMaterial( Material( "mrcb_mods/huds/cs/ui_bars.png" ) )
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.DrawTexturedRect( ScrW() - 266, ScrH() - 338, 266, 338 )

            if stalk_ply_armor > 0 then
            surface.SetMaterial( Material( "mrcb_mods/huds/cs/ui_bars_arm.png" ) )
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.DrawTexturedRect( ScrW() - 266, ScrH() - 100, 164, 27 )
            end

                --Health bar
            surface.SetMaterial( Material( "mrcb_mods/huds/cs/ui_health.png" ) )
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.DrawPartialTexturedRect( ScrW() - 114 - 117, ScrH() - 9 - 55, 114 * (stalk_ply_health * 0.01), 9, 0, 0, 114 * (stalk_ply_health * 0.01), 9, 114, 9)

                --Armor bar
            surface.SetMaterial( Material( "mrcb_mods/huds/cs/ui_armor.png" ) )
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.DrawPartialTexturedRect( ScrW() - 114 - 117, ScrH() - 9 - 75, 114 * (stalk_ply_armor * 0.01), 9, 0, 0, 114 * (stalk_ply_armor * 0.01), 9, 114, 9)

                --Ammo panel
            surface.SetTextPos(ScrW() - 160, ScrH() - 35)
            surface.SetFont("HudHintTextLarge")
            surface.SetTextColor(255,123,0)
            if stalk_ply_clipcount != " " then

                surface.DrawText(tostring(stalk_ply_clipcount .. "/" .. stalk_ply_ammocount))

            else

                surface.DrawText(stalk_ply_ammocount)
                
            end

            surface.SetTextPos(ScrW() - 123, ScrH() - 16)
            surface.SetFont("HudHintTextLarge")
            surface.SetTextColor(255,174,0)
            surface.DrawText(tostring(stalk_ply_weap_firemode))

            stalk_drawammo( 210, 25, 0.85)

                --Radar/Minimap
            surface.SetMaterial( Material( "mrcb_mods/huds/cs/ui_radar.png" ) )
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.DrawTexturedRect( 9, 3, 196, 191 )

                --Targets Display
            for i = 1, #stalk_ply_targets_radared do

                local xpos = (stalk_ply_targets_radared[i].pos.xpos)  + (3 + 191) / 2
                local ypos = (stalk_ply_targets_radared[i].pos.ypos)  + (9 + 185) / 2

                if (xpos > 25 and xpos < 187) and (ypos > 20 and ypos < 177) then

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

                --OS Time
            surface.SetFont("Default")
            surface.SetTextPos(160, 7)
            surface.SetTextColor(255,174,0)
            surface.DrawText(os.date( "%H:%M" ))

               --Compas
            surface.SetMaterial( Material( "mrcb_mods/huds/cs/ui_compas.png" ) )
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.DrawTexturedRectRotated( 9 + 196 - 37, 40, 31, 31 , LocalPlayer():GetAngles().y * -1 - 90)

            surface.SetMaterial( Material( "mrcb_mods/huds/cs/ui_counter.png" ) )
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.DrawTexturedRect( 123, 170, 80, 28 )

            local counter = 0

            for i = 1, #stalk_ply_targets_radared do

                if stalk_ply_targets_radared[i].class != "prop_ragdoll" then

                    counter = counter + 1
                    
                end

            end

            if counter > 1 then
            local xw,yh = surface.GetTextSize( counter - 1 )
            surface.SetTextPos(185 - xw / 2, 176)
            surface.SetFont("HudHintTextLarge")
            surface.SetTextColor(255,230,0)
            surface.DrawText(tostring(counter - 1))
            end
        end

    end)    

end