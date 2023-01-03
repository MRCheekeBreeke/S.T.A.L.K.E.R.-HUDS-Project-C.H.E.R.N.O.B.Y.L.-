if CLIENT then

    ------------------------------------------------------------
	--	HUD Special Function
	--	Author: thejjokerr
	------------------------------------------------------------
    function surface.DrawPartialTexturedRect( x, y, w, h, partx, party, partw, parth, texw, texh )
        /* Source: http://facepunch.com/showthread.php?t=1026117 */
            --[[ 
                Arguments:
                x: Where is it drawn on the x-axis of your screen
                y: Where is it drawn on the y-axis of your screen
                w: How wide must the image be?
                h: How high must the image be?
                partx: Where on the given texture's x-axis can we find the image you want?
                party: Where on the given texture's y-axis can we find the image you want?
                partw: How wide is the partial image in the given texture?
                parth: How high is the partial image in the given texture?
                texw: How wide is the texture?
                texh: How high is the texture?
            ]]--
            
            -- Verify that we recieved all arguments
            if not( x && y && w && h && partx && party && partw && parth && texw && texh ) then
                ErrorNoHalt("surface.DrawPartialTexturedRect: Missing argument!")	
                
                return	
            end	
            
            -- Get the positions and sizes as percentages / 100
            local percX, percY = partx / texw, party / texh	
            local percW, percH = partw / texw, parth / texh	
            
            -- Process the data
            local vertexData = {
                {
                    x = x,
                    y = y,
                    u = percX,
                    v = percY
                },
                {
                    x = x + w,
                    y = y,
                    u = percX + percW,
                    v = percY
                },
                {
                    x = x + w,
                    y = y + h,
                    u = percX + percW,
                    v = percY + percH
                },
                {
                    x = x,
                    y = y + h,
                    u = percX,
                    v = percY + percH
                }
            }	
                
            surface.DrawPoly( vertexData )	
        end	  

        function stalk_drawammo( x, y, sizemod)

            local stalk_ply_ammoicon
    
                if stalk_ply_ammoname == "COP_545" then
    
                    stalk_ply_ammoicon = Material("mrcb_mods/huds/all/ammo/545.png")
                    
                elseif stalk_ply_ammoname == " " then
    
                    stalk_ply_ammoicon = " "
    
                elseif stalk_ply_ammoname == "COP_45ACP" or stalk_ply_ammoname == "357" then
    
                    stalk_ply_ammoicon = Material("mrcb_mods/huds/all/ammo/45.png")
    
                elseif stalk_ply_ammoname == "COP_12x70BUCK" or stalk_ply_ammoname == "Buckshot" then
    
                    stalk_ply_ammoicon = Material("mrcb_mods/huds/all/ammo/buck.png")
    
                elseif stalk_ply_ammoname == "COP_9x18MM" or stalk_ply_ammoname == "Pistol" then
    
                    stalk_ply_ammoicon = Material("mrcb_mods/huds/all/ammo/918.png")
    
                elseif stalk_ply_ammoname == "COP_556" or stalk_ply_ammoname == "SMG1" then
    
                    stalk_ply_ammoicon = Material("mrcb_mods/huds/all/ammo/556.png")
    
                elseif stalk_ply_ammoname == "COP_BATTERY" then
    
                    stalk_ply_ammoicon = Material("mrcb_mods/huds/all/ammo/gauss.png")
    
                elseif stalk_ply_ammoname == "COP_9x19MM" then
    
                    stalk_ply_ammoicon = Material("mrcb_mods/huds/all/ammo/919.png")
    
                elseif stalk_ply_ammoname == "COP_9x39MM" or stalk_ply_ammoname == "AR2" then
    
                    stalk_ply_ammoicon = Material("mrcb_mods/huds/all/ammo/939.png")
    
                elseif stalk_ply_ammoname == "COP_762x42MMR" or stalk_ply_ammoname == "XBowBolt" then
    
                    stalk_ply_ammoicon = Material("mrcb_mods/huds/all/ammo/762.png")
                    
                else
    
                    stalk_ply_ammoicon = Material("mrcb_mods/huds/all/ammo/unknown.png")
    
                end
    
                if stalk_ply_ammoicon != " " then
                    surface.SetMaterial( stalk_ply_ammoicon ) 
                    surface.SetDrawColor( 255, 255, 255, 255 )
                    surface.DrawTexturedRect( ScrW() - (stalk_ply_ammoicon:Width() - stalk_ply_ammoicon:Width() / 2) - x, ScrH() - (stalk_ply_ammoicon:Height() - stalk_ply_ammoicon:Height() / 2) - y, stalk_ply_ammoicon:Width() * sizemod, stalk_ply_ammoicon:Height() * sizemod)
    
                end
            end

    --VARIABLES FOR STYLES
    stalk_ply_health = 100  
    stalk_ply_armor = 0
    stalk_ply_movetype = nil
    stalk_ply_ammoname = " "
    stalk_ply_ammocount = 0
    stalk_ply_secammocount = 0
    stalk_ply_clipcount = 0
    stalk_ply_weap_firemode = ""

    stalk_ply_targets = {}
    stalk_ply_radar_targets = {}
    stalk_ply_targets_radared = {}

    --VARIABLES UPDATE
    hook.Add("HUDPaint", "stalk_vars_init", function()

        surface.SetFont("HudHintTextLarge")
        surface.SetTextColor(255,255,255)
        surface.SetTextPos(ScrW() - 230, 0)
        surface.DrawText("S.T.A.L.K.E.R. HUDs System v0.2a")
        surface.SetTextPos(ScrW() - 147, 15)
        surface.DrawText("By MR.CheekeBreeke")

        stalk_ply_targets = {}
        stalk_ply_radar_targets = {}
        stalk_ply_targets_radared = {}

         --Radar NPC & Players searching
       stalk_ply_targets = ents.FindInSphere(LocalPlayer():GetPos(), GetConVar("stalk_hud_radar_radius"):GetInt())

       for i = 1, #stalk_ply_targets do
           
           if stalk_ply_targets[i]:IsNPC() or (stalk_ply_targets[i]:IsPlayer() and stalk_ply_targets[i]:Alive()) or stalk_ply_targets[i]:IsRagdoll() then
               
               for j = 1, #stalk_ply_radar_targets + 1 do
                   
                   if stalk_ply_radar_targets[j] == nil then
                       
                       stalk_ply_radar_targets[j] = stalk_ply_targets[i]

                       break

                   end

               end

           end

       end

       for i = 1, #stalk_ply_radar_targets do
           for j = 1, #stalk_ply_targets_radared + 1 do
               
               if stalk_ply_targets_radared[j] == nil then
                   
                   stalk_ply_targets_radared[j] = {
                       pos = {
                           xpos = ((stalk_ply_radar_targets[i]:GetPos().y - LocalPlayer():GetPos().y) * math.sin( math.rad( LocalPlayer():GetAngles().y + 90 * -1) ) - (stalk_ply_radar_targets[i]:GetPos().x - LocalPlayer():GetPos().x) * math.cos( math.rad( LocalPlayer():GetAngles().y + 90))) / (GetConVar("stalk_hud_radar_radius"):GetInt() * 0.009), 
                           ypos = ((stalk_ply_radar_targets[i]:GetPos().y - LocalPlayer():GetPos().y) * math.cos( math.rad( LocalPlayer():GetAngles().y + 90) ) - (stalk_ply_radar_targets[i]:GetPos().x - LocalPlayer():GetPos().x) * math.sin( math.rad( LocalPlayer():GetAngles().y + 90))) / (GetConVar("stalk_hud_radar_radius"):GetInt() * 0.009)
                       },

                       class = stalk_ply_radar_targets[i]:GetClass()
                   }
                   break

               end

           end

       end

        --Ammo Reader
        if IsValid(LocalPlayer():GetActiveWeapon()) then
            
            if game.GetAmmoName( LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) != nil then
                
            stalk_ply_ammoname = game.GetAmmoName( LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType())

                if LocalPlayer():GetActiveWeapon():Clip1() != -1 then
                    
                stalk_ply_ammocount = tostring(LocalPlayer():GetAmmoCount( LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType() ))
                stalk_ply_clipcount = tostring( LocalPlayer():GetActiveWeapon():Clip1() )

                else

                    stalk_ply_clipcount = LocalPlayer():GetAmmoCount( LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType() )
                    stalk_ply_ammocount = " "
                    
                end

                if LocalPlayer():GetActiveWeapon():GetSecondaryAmmoType() != -1 then
                    
                    stalk_ply_secammocount = LocalPlayer():GetAmmoCount( LocalPlayer():GetActiveWeapon():GetSecondaryAmmoType())
    
                else
    
                    stalk_ply_secammocount = "  "
                        
                end

            else

                stalk_ply_ammoname = " "
                stalk_ply_ammocount = " "
                stalk_ply_clipcount = " "
                stalk_ply_secammocount = " "

            end

            if LocalPlayer():GetActiveWeapon().Primary != nil then
                
                if LocalPlayer():GetActiveWeapon().Primary.Automatic then
                    stalk_ply_weap_firemode = "A"
                else
                    stalk_ply_weap_firemode = "1"
                end
            
            else

                stalk_ply_weap_firemode = ""

            end

        end

        --Smooth Health and Armor
        if LocalPlayer():Alive() then

        if stalk_ply_health < LocalPlayer():Health() and stalk_ply_health < 100 then

            stalk_ply_health = stalk_ply_health + 1
            
        elseif stalk_ply_health > LocalPlayer():Health() and stalk_ply_health > 0 then

            stalk_ply_health = stalk_ply_health - 1

        end

        if stalk_ply_armor < LocalPlayer():Armor() then

            stalk_ply_armor = stalk_ply_armor + 1
            
        elseif stalk_ply_armor > LocalPlayer():Armor() then

            stalk_ply_armor = stalk_ply_armor - 1

        end

        else

            stalk_ply_health = 100
            stalk_ply_armor = 0

        end

        --Move type
        if LocalPlayer():GetMoveType() == 9 then
            
            stalk_ply_movetype = "LADDER"

        elseif LocalPlayer():Crouching() then
            
            stalk_ply_movetype = "CROUCH"

        elseif (LocalPlayer():KeyDown( 8 ) or LocalPlayer():KeyDown( 16 ) or LocalPlayer():KeyDown( 512 ) or LocalPlayer():KeyDown( 1024 )) and LocalPlayer():KeyDown( 131072 ) then

            stalk_ply_movetype = "RUN"

        elseif (LocalPlayer():KeyDown( 8 ) or LocalPlayer():KeyDown( 16 ) or LocalPlayer():KeyDown( 512 ) or LocalPlayer():KeyDown( 1024 )) then

            stalk_ply_movetype = "WALK"

        else
            
            stalk_ply_movetype = "IDLE"

        end
        
    end)

    CreateConVar( "stalk_hud_style", "soc", FCVAR_ARCHIVE, "Sets HUD style for you")
    CreateConVar( "stalk_hud_toggle", 1, FCVAR_ARCHIVE, "Toggle HUD or not", 0, 1)
    CreateConVar( "stalk_hud_radar_radius", 1000, {FCVAR_ARCHIVE, FCVAR_CHEAT}, "Radius of Radar", 500, 2500)

    --Cleaning standart hud

    local stalk_hud_clear_table = {
        ["CHudHealth"] = true,
        ["CHudBattery"] = true,
        ["CHudAmmo"] = true,
        ["CHudSecondaryAmmo"] = true,
        ["CHudHistoryResource"] = true
    }

    hook.Add( "HUDDrawPickupHistory", "stalk_hud_pickup_clear", function()
        if GetConVar( "stalk_hud_toggle" ):GetInt() == 1 then
                return false
        end
    end )

    hook.Add( "DrawDeathNotice", "stalk_hud_deathnotice_clear", function()
        if GetConVar( "stalk_hud_toggle" ):GetInt() == 1 then
                return false
        end
    end )

    hook.Add( "HUDShouldDraw", "stalk_hud_clear", function( name )
        if GetConVar( "stalk_hud_toggle" ):GetInt() == 1 then
            if ( stalk_hud_clear_table[ name ] ) then
                return false
            end
        end
    end)

end