--#Call of Pripyat

if CLIENT then

    hook.Add("HUDPaint", "stalk_cop_interface", function()

        if GetConVar( "stalk_hud_style" ):GetString() == "cop" and GetConVar( "stalk_hud_toggle" ):GetInt() == 1 and LocalPlayer():Alive() then 
            
                --Health and armor panel
            surface.SetMaterial( Material( "mrcb_mods/huds/cop/ui_bars.png" ) )
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.DrawTexturedRect( ScrW() - 226, ScrH() - 131, 222, 126 )

                --Health bar
            surface.SetMaterial( Material( "mrcb_mods/huds/cop/ui_health.png" ) )
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.DrawPartialTexturedRect( ScrW() - 138 - 32, ScrH() - 16 - 101, 138 * (stalk_ply_health * 0.01), 16, 0, 0, 138 * (stalk_ply_health * 0.01), 16, 138, 16)

                --Armor icon

            if LocalPlayer():Armor() < 90 then

                if LocalPlayer():Armor() < 25 then

                    surface.SetMaterial( Material( "mrcb_mods/huds/cop/ui_armor/ui_armor_h.png" ) )

                elseif LocalPlayer():Armor() < 50 then

                    surface.SetMaterial( Material( "mrcb_mods/huds/cop/ui_armor/ui_armor_mh.png" ) )

                elseif LocalPlayer():Armor() < 75 then

                    surface.SetMaterial( Material( "mrcb_mods/huds/cop/ui_armor/ui_armor_m.png" ) )

                elseif LocalPlayer():Armor() < 90 then

                    surface.SetMaterial( Material( "mrcb_mods/huds/cop/ui_armor/ui_armor_l.png" ) )

                end

                surface.SetDrawColor( 255, 255, 255, 255 )
                surface.DrawTexturedRect( ScrW() - 38, ScrH() - 165, 33, 35)

            end

                --Ammo panel
            surface.SetFont("Trebuchet24")
            local stalk_ammodcount_w ,stalk_ammodcount_h = surface.GetTextSize( stalk_ply_clipcount )
            surface.SetTextPos(ScrW() - stalk_ammodcount_w / 2 - 135, ScrH() - stalk_ammodcount_h / 2 - 62)
            surface.SetTextColor(255,174,0)
            surface.DrawText(tostring(stalk_ply_clipcount))

            surface.SetFont("HudHintTextLarge")
            local stalk_ammodcount_w ,stalk_ammodcount_h = surface.GetTextSize( stalk_ply_ammocount )
            surface.SetTextPos(ScrW() - stalk_ammodcount_w / 2 - 152, ScrH() - stalk_ammodcount_h / 2 - 35)
            surface.SetTextColor(255,174,0)
            surface.DrawText(tostring(stalk_ply_ammocount))

            surface.SetFont("HudHintTextLarge")
            local stalk_ammodcount_w ,stalk_ammodcount_h = surface.GetTextSize( stalk_ply_secammocount )
            surface.SetTextPos(ScrW() - stalk_ammodcount_w / 2 - 120, ScrH() - stalk_ammodcount_h / 2 - 35)
            surface.SetTextColor(255,174,0)
            surface.DrawText(tostring(stalk_ply_secammocount))
            
            stalk_drawammo( 50, 40, 1)

            surface.SetTextPos(ScrW() - 193, ScrH() - 40)
            surface.SetFont("HudHintTextLarge")
            surface.SetTextColor(255,174,0)
            surface.DrawText(tostring(stalk_ply_weap_firemode))

                --Radar/Minimap
            surface.SetMaterial( Material( "mrcb_mods/huds/cop/ui_radar.png" ) )
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.DrawTexturedRect( 9, 3, 218, 218 )

                --OS Time
            surface.SetFont("Trebuchet18")
            surface.SetTextPos(19, 189)
            surface.SetTextColor(255,174,0)
            surface.DrawText(os.date( "%H:%M" ))

               --Compas
            surface.SetMaterial( Material( "mrcb_mods/huds/cop/ui_compas.png" ) )
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.DrawTexturedRectRotated( 9 + 26, 3 + 26, 9, 30 , LocalPlayer():GetAngles().y * -1 - 90)

                    --Targets Display
                for i = 1, #stalk_ply_targets_radared do
    
                    local xpos = (stalk_ply_targets_radared[i].pos.xpos) * 0.675  + (8 + 218) / 2
                    local ypos = (stalk_ply_targets_radared[i].pos.ypos) * 0.675  + (3 + 218) / 2
    
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
    
                local counter = 0
    
                for i = 1, #stalk_ply_targets_radared do
    
                    if stalk_ply_targets_radared[i].class != "prop_ragdoll" then
    
                        counter = counter + 1
                        
                    end
    
                end
    
                if counter > 1 then
                    
                    if counter <= 10 then

                surface.SetTextPos(211, 109)

                    else
                    
                 surface.SetTextPos(207, 109)
                        
                    end
                surface.SetFont("HudHintTextLarge")
                surface.SetTextColor(255,230,0)
                surface.DrawText(tostring(counter - 1))

                end
     

        end

    end)

end