<h1 align="center"> [Project C.H.E.R.N.O.B.Y.L.] S.T.A.L.K.E.R HUDs </h1>

This addon adds the HUD system from the S.T.A.L.K.E.R Trilogy. to the game, with custom styles support.

---
<h2 align="left"> What does it do? </h2>
This addon is a port of the interface from the game S.T.A.L.K.E.R. in Garry's Mod. The addon not only transfers the interface, but also allows you to save its functionality.
The addon has support for custom styles. This means that everyone can create their own style, or try to transfer the interface from any mod to S.T.A.L.K.E.R.

---

<h2 align="left"> Console Variables </h2>

- Clientside variables
  - stalk_hud_style – Setup style
  - stalk_hud_toggle – On/Off HUD
  - stalk_hud_radar_radius - Setup radius for radar (Posted only temporarily. Will be removed in the future!)

- Serverside variables
  - So far they are missing...

---
<h2 align="left"> How i can create my own style? </h2>
First, it is desirable for you to have a basic knowledge of the Lua language, because addons for Garry's Mod are written on it.


Secondly, you should take into account that the addon introduces its own variables, and you do not need to constantly do new calculations. The addon will do everything for you.

<h3 align="left"> List of variables </h3>

- Clientside variables
  - stalk_ply_health  –  Player Health (number)
  - stalk_ply_armor  –  Player Armor (number)
  - stalk_ply_movetype  –  Player Move Type [example:"LADDER","CROUCH","RUN"] (string)
  - stalk_ply_ammoname  –  Player current ammo name (string)
  - stalk_ply_ammocount  –  Player current ammo count (number)
  - stalk_ply_secammocount  –  Player current secondary ammo count (number)
  - stalk_ply_clipcount  –  Player current ammo count in weapon clip (number)
  - stalk_ply_weap_firemode  –  Player current weapon fire mode (string)
  - stalk_ply_stalk_ply_targets_radared  –  Radared NPCs, Players and Ragdolls in radar radius (table)
  
- Serverside variables
  - So far they are missing...
