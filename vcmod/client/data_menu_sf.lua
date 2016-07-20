
-----------------------------------------------------
local function BuildMenu(Pnl)  local Font_Link = "VC_Link" if !VC.Fonts[Font_Link] then VC.Fonts[Font_Link] = true surface.CreateFont(Font_Link, {font = "MenuLarge", size = 14, weight = 0, blursize = 0, scanlines = 0, antialias = true, underline = true, italic = false, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false, outline = false}) end   local PW = Pnl:GetWide()  local List = VC.Add_El_List(5, 40, PW, Pnl:GetTall()-100) List:SetParent(Pnl)   local MPnl = VC.Add_El_Panel(List, {0.2,0.15, 0.25,0.2,0.1}, 25, true)  local SNLbl = vgui.Create("DLabel") SNLbl:SetText(VC.Lng('Language')) SNLbl:SetWide(PW*0.3) SNLbl:SetColor(Color(200,200,255,255)) SNLbl:SetFont("VC_Info_Small") MPnl[1]:AddItem(SNLbl)  local SNLbl = vgui.Create("DLabel") SNLbl:SetText(VC.Lng('Revision')) SNLbl:SetWide(PW*0.3) SNLbl:SetFont("VC_Info_Smaller") MPnl[2]:AddItem(SNLbl)  local SNLbl = vgui.Create("DLabel") SNLbl:SetText(VC.Lng('Author')) SNLbl:SetWide(PW*0.3) SNLbl:SetFont("VC_Info_Smaller") MPnl[3]:AddItem(SNLbl)  local SNLbl = vgui.Create("DLabel") SNLbl:SetText(VC.Lng('Date')) SNLbl:SetWide(PW*0.3) SNLbl:SetFont("VC_Info_Smaller") MPnl[4]:AddItem(SNLbl)  local SNLbl = vgui.Create("DLabel") SNLbl:SetText(VC.Lng('Status')) SNLbl:SetWide(PW*0.3) SNLbl:SetFont("VC_Info_Smaller") MPnl[5]:AddItem(SNLbl)   if VC.Lng_T then  for k,v in SortedPairs(VC.Lng_T) do  local MPnl = VC.Add_El_Panel(List, {0.2,0.15,0.25,0.2, 0.15}, 20, 2)  local SNLbl = vgui.Create("DLabel") SNLbl:SetText(VC.Lng_T_Rev[k]) SNLbl:SetWide(PW*0.2) SNLbl:SetColor(VC.Color.Good) MPnl[2]:AddItem(SNLbl)  local SNLbl = vgui.Create("DLabel") SNLbl:SetText(string.upper(k).."  "..v.Name) SNLbl:SetWide(PW*0.25) SNLbl:SetColor(Color(200,200,255,255)) MPnl[1]:AddItem(SNLbl)  local UpToDate = table.Count(v) >= table.Count(VC.Lng_Default) local SNLbl = vgui.Create("DLabel") SNLbl:SetText(UpToDate and VC.Lng("Good") or VC.Lng("Outdated")) SNLbl:SetWide(PW*0.3) SNLbl:SetColor(UpToDate and VC.Color.Good or VC.Color.Bad) MPnl[5]:AddItem(SNLbl)  local Btn = vgui.Create("DButton") Btn:SetSize(50, 15) Btn:SetText("") MPnl[3]:AddItem(Btn)  Btn.DoClick = function() if v.Translated_By_Link then gui.OpenURL(v.Translated_By_Link) else VCPopup("Sorry, no link found.", "cross") end end  Btn.Paint = function(obj, Sx, Sy)  if Btn:IsHovered() then draw.RoundedBox(0, 0, 0, Sx, Sy, Color(0, 25, 55, 255)) end  draw.DrawText((v.Translated_By_Name or "-"), Font_Link, 0, 2,  Color(255,255,255,255), TEXT_ALIGN_LEFT)  end  local SNLbl = vgui.Create("DLabel") SNLbl:SetText(v.Translated_Date or "-") SNLbl:SetWide(PW*0.3) MPnl[4]:AddItem(SNLbl)  end  end   local Btn = vgui.Create("DButton") Btn:SetSize(Pnl:GetWide()-10, 50) Btn:SetPos(5, Pnl:GetTall()-Btn:GetTall()-5) Btn:SetText("") Btn:SetParent(Pnl)  Btn.DoClick = function() RunConsoleCommand("vc_menu_open_translation") VC.Menu_Panel:Close() end  Btn.Paint = function(obj, Sx, Sy)  draw.RoundedBox(0, 0, 0, Sx, Sy, Color(0, 155, 100, Btn:IsHovered() and 55 or 20))  draw.DrawText(VC.Lng("WishToHelpTranslate"), "VC_Info_Smaller", Sx/2, 18, Color(200, 225, 255, 255), TEXT_ALIGN_CENTER)  end   local X, Y = List:GetPos() local Sx, Sy = List:GetSize()  Pnl.Paint = function(obj, Sx, Sy)  draw.RoundedBox(0, X-5, Y, Sx, 21, Color(0, 0, 0, 150))  draw.RoundedBox(0, X-5, Y, Sx, Sy, Color(0, 0, 0, 150))  draw.RoundedBox(0, X-5, Sx-57, Sy, 57, Color(0, 0, 0, 150))  draw.DrawText(VC.Lng("BigThankYouToAllWhoHelpedTranslate"), "VC_Dev_Text", List:GetWide()/2, 5, VC.Color.Neutral, TEXT_ALIGN_CENTER)  end   return Draw end VC.Menu_Items_P.Language = {"Language", BuildMenu}  timer.Simple(1, function()  local function BuildMenu(Pnl)  local List = VC.Add_El_List(0, 35, Pnl:GetWide(), Pnl:GetTall()-35) List:SetParent(Pnl)   local CBox = VC.Add_El_Checkbox("Enabled_Cl", "Basically shuts down all the stuff bellow.", "Enabled", VC.Settings) List:AddItem(CBox)  local MPnl_M = VC.Add_El_Panel(List, {1}, 222)  local SNLbl = vgui.Create("DLabel") SNLbl:SetText(VC.Lng("Lights")..":") MPnl_M[1]:AddItem(SNLbl)   local LType = vgui.Create("DComboBox", List) LType:AddChoice(VC.Lng("Blurred")) LType:AddChoice(VC.Lng("Rays")) LType:SetSize(100, 24) LType:SetPos(List:GetWide()-LType:GetWide(),10) LType:ChooseOptionID(VC.Settings.Light_Type) LType.OnSelect = function(idx, val) VC.SaveSetting("Light_Type", val) end   local MPnl_M2 = VC.Add_El_Panel(MPnl_M[1], {1}, 202)  local Sldr = VC.Add_El_Slider("VisDist", 0, 15000, 0, "How far the lights can be seen, reduces the lag a bit.", "LightDistance", VC.Settings) MPnl_M2[1]:AddItem(Sldr)   local MPnl = VC.Add_El_Panel(MPnl_M2[1], {0.25, 0.75}, 32, true)  local SNLbl = vgui.Create("DLabel") SNLbl:SetText("") SNLbl:SetTall(8) MPnl[1]:AddItem(SNLbl)  local CBox = VC.Add_El_Checkbox("Main", "Main texture to outline the light.", "Light_Main", VC.Settings) MPnl[1]:AddItem(CBox)  local Sldr = VC.Add_El_Slider("Multiplier", 0, 5, 2, "Will be multiplied by this amount.", "Light_Main_M", VC.Settings) MPnl[2]:AddItem(Sldr)   local MPnl = VC.Add_El_Panel(MPnl_M2[1], {0.25, 0.75}, 32, true)  local SNLbl = vgui.Create("DLabel") SNLbl:SetText("") SNLbl:SetTall(8) MPnl[1]:AddItem(SNLbl)  local CBox = VC.Add_El_Checkbox("Warmth", "Creates a new light in the middle, blends the two together.", "Light_Warm", VC.Settings) MPnl[1]:AddItem(CBox)  local Sldr = VC.Add_El_Slider("Multiplier", 0, 5, 2, "Will be multiplied by this amount.", "Light_Warm_M", VC.Settings) MPnl[2]:AddItem(Sldr)   local MPnl = VC.Add_El_Panel(MPnl_M2[1], {0.25, 0.75}, 32, true)  local SNLbl = vgui.Create("DLabel") SNLbl:SetText("") SNLbl:SetTall(8) MPnl[1]:AddItem(SNLbl)  local CBox = VC.Add_El_Checkbox("Lines", "The lines you see around lights if its bright enough.", "Light_HD", VC.Settings) MPnl[1]:AddItem(CBox)  local Sldr = VC.Add_El_Slider("Multiplier", 0, 5, 2, "Will be multiplied by this amount.", "Light_HD_M", VC.Settings) MPnl[2]:AddItem(Sldr)   local MPnl = VC.Add_El_Panel(MPnl_M2[1], {0.25, 0.75}, 32, true)  local SNLbl = vgui.Create("DLabel") SNLbl:SetText("") SNLbl:SetTall(8) MPnl[1]:AddItem(SNLbl)  local CBox = VC.Add_El_Checkbox("Glow", "The very transparent glow around the lights.", "Light_Glow", VC.Settings) MPnl[1]:AddItem(CBox)  local Sldr = VC.Add_El_Slider("Multiplier", 0, 5, 2, "Will be multiplied by this amount.", "Light_Glow_M", VC.Settings) MPnl[2]:AddItem(Sldr)   local CBox = VC.Add_El_Checkbox("3D", "This light object renders in 3D instead of dot based style.", "Light_3D", VC.Settings) MPnl_M2[1]:AddItem(CBox)   local MPnl = VC.Add_El_Panel(MPnl_M2[1], {0.25, 0.75}, 32, true)  local SNLbl = vgui.Create("DLabel") SNLbl:SetText("") SNLbl:SetTall(8) MPnl[1]:AddItem(SNLbl)  local CBox = VC.Add_El_Checkbox("DynamicLights", "If lights are lagging for you, uncheck this.", "DynamicLights", VC.Settings) MPnl[1]:AddItem(CBox)  local Sldr = VC.Add_El_Slider("FadeOutDistance", 1000, 10000, 0, "Dynamic lights will turn off at this distance (gradually). Fades from 1 to 0 in 1000 units.", "DynamicLights_OffDist", VC.Settings) MPnl[2]:AddItem(Sldr)   local Sheet = vgui.Create("DPropertySheet") Sheet:SetTall(210)  if VC.CreateClSettingsTab_VC1 then local TList = VC.Add_El_List(0, 6, 450, Sheet:GetTall()) Sheet:AddSheet(VC.Lng("ThirdPersonView"), TList, "icon16/user_red.png", false, false, "Controls for the VCMod Main Package.") VC.CreateClSettingsTab_VC1(List, TList) end  if VC.CreateClSettingsTab_VC1_ELS then local TList = VC.Add_El_List(0, 6, 450, Sheet:GetTall()) Sheet:AddSheet(VC.Lng("ELS"), TList, "icon16/user_orange.png", false, false, "Controls for the VCMod ELS package.") VC.CreateClSettingsTab_VC1_ELS(List, TList) end  List:AddItem(Sheet)   local Btn = vgui.Create("VC_Button") Btn:SetColor(VC.Color.Btn_Orn) Btn:SetSize(75, 20) Btn:SetPos(Pnl:GetWide()/2-35, Pnl:GetTall()-24) Btn:SetText(VC.Lng("Reset")) Btn:SetParent(Pnl) Btn:SetToolTip("Reset all settings to their default values.")  Btn.DoClick = function() VC.ResetSettings() if VC.Menu_Panel then VC.Menu_Panel.VC_Refresh_Panel = true end VCPopup("SettingsReset", "check") end   local X, Y = List:GetPos() local Sx, Sy = List:GetSize()  Pnl.Paint = function(obj, Sx, Sy)  draw.RoundedBox(0, X, Y, Sx, Sy, Color(0, 0, 0, 100))  draw.DrawText(VC.Lng("OptOnly_You"), "VC_Dev_Text", List:GetWide()/2, 5, VC.Color.Neutral, TEXT_ALIGN_CENTER)  end   return Draw  end  VC.Menu_Items_P.Personal = {"Options", BuildMenu, Check = function() return VCMod1 or VCMod1_ELS end} end)  local function BuildMenu(Pnl)  local List = VC.Add_El_List(0, 6, 450, 550) List:SetParent(Pnl)  local List2 = VC.Add_El_List(459, 6, 146, 458) List2:SetParent(Pnl)   local MPnl = VC.Add_El_Panel(List, {0.5,0.5}, 32, 2)  local SNLbl = vgui.Create("DLabel") SNLbl:SetText("") SNLbl:SetTall(2) MPnl[1]:AddItem(SNLbl)  local Cmd = nil for k,v in pairs(VC.Controls_Main) do if v.cmd == "vc_holdkey" then Cmd = v end end local VCBtn = vgui.Create("VC_Control") VCBtn.VC_BtnInfo = {Cmd.info, Cmd.keyhold} VCBtn.VC_BtnCmd = Cmd.cmd if Cmd.desk then VCBtn:SetToolTip(Cmd.desk) end MPnl[1]:AddItem(VCBtn)  local Sldr = VC.Add_El_Slider("HoldDuration", 0.1, 1, 1, "Buttons with checkbox checked will only work after this hold delay.", "Keyboard_Input_Hold", VC.Settings) Sldr:SetSize(450, 30) MPnl[2]:AddItem(Sldr)   local Sheet = vgui.Create("DPropertySheet") Sheet:SetTall(455)   if VCMod1 then local TList = VC.Add_El_List(0, 6, 450, 505) Sheet:AddSheet(VC.Lng("Main"), TList, "icon16/user_red.png", false, false, "Controls for the VCMod Main Package.") for _, Cmd in pairs(VC.Controls_Main) do if Cmd.menu == "controls" then local VCBtn = vgui.Create(Cmd.NoCheckBox and "VC_Control" or "VC_Control_CheckBox") VCBtn.VC_BtnInfo = {Cmd.info, Cmd.keyhold} VCBtn.VC_BtnCmd = Cmd.cmd if Cmd.desk then VCBtn:SetToolTip(Cmd.desk) end TList:AddItem(VCBtn) end end end  if VCMod1_ELS then local TList = VC.Add_El_List(0, 6, 450, 505) Sheet:AddSheet(VC.Lng("ELS"), TList, "icon16/user_orange.png", false, false, "Controls for the VCMod ELS package.") for _, Cmd in pairs(VC.Controls_Main) do if Cmd.menu == "controls_els" then local VCBtn = vgui.Create(Cmd.NoCheckBox and "VC_Control" or "VC_Control_CheckBox") VCBtn.VC_BtnInfo = {Cmd.info, Cmd.keyhold} VCBtn.VC_keyhold = Cmd.keyhold VCBtn.VC_BtnCmd = Cmd.cmd if Cmd.desk then VCBtn:SetToolTip(Cmd.desk) end TList:AddItem(VCBtn) end end end   List:AddItem(Sheet)   local CBox = VC.Add_El_Checkbox("KeyboardInput", "Toggles all controls, excluding the mouse buttons.", "Keyboard_Input", VC.Settings) List2:AddItem(CBox)  local CBox = VC.Add_El_Checkbox("MouseInput", "Toggles mouse button controls.", "MouseControl", VC.Settings) List2:AddItem(CBox)    if vcmod1 then  local SNLbl = vgui.Create("DLabel") SNLbl:SetText(VC.Lng("SwitchSeats")) List2:AddItem(SNLbl)  local SNLbl = vgui.Create("DLabel") SNLbl:SetText("'1-9', '0'.") List2:AddItem(SNLbl)  local SNLbl = vgui.Create("DLabel") SNLbl:SetText("") List2:AddItem(SNLbl)  local SNLbl = vgui.Create("DLabel") SNLbl:SetText(VC.Lng("KickPeopleOut")) List2:AddItem(SNLbl)  local SNLbl = vgui.Create("DLabel") SNLbl:SetText(VC.Lng("Holdkey").."+ ('1-9', '0').") List2:AddItem(SNLbl)  end   local Btn = vgui.Create("VC_Button") Btn:SetColor(VC.Color.Btn_Orn) Btn:SetSize(75, 20) Btn:SetPos(187.5, Pnl:GetTall()-20) Btn:SetText(VC.Lng("Reset")) Btn:SetParent(Pnl) Btn:SetToolTip("Reset all controls to their default values, changes settings of all addons, not just this one.")  Btn.DoClick = function() VC.Controls_CreateScript() if VC.Menu_Panel then VC.Menu_Panel.VC_Refresh_Panel = true end VCPopup("ControlsReset", "check") end   Pnl.Paint = function(obj, Sx, Sy) draw.RoundedBox(0, 453, 0, 152, Sy, Color(0, 0, 0, 100)) end end VC.Menu_Items_P.Controls = {"Controls", BuildMenu, Check = function() return VCMod1 or VCMod1_ELS end}  local function BuildMenu(Pnl)  local List = VC.Add_El_List(0, 35, Pnl:GetWide(), Pnl:GetTall()-35) List:SetParent(Pnl)   local MPnl = VC.Add_El_Panel(List, {0.5,0.5}, 32, true)  local SNLbl = vgui.Create("DLabel") SNLbl:SetText("") SNLbl:SetTall(8) MPnl[1]:AddItem(SNLbl)  local CBox = VC.Add_El_Checkbox("Effect3D", "When you sway your mouse around the HUD tries to stay with the view.", "HUD_3D", VC.Settings) MPnl[1]:AddItem(CBox)  local Sldr = VC.Add_El_Slider("Multiplier", 0, 3, 2, "How much the view will sway.", "HUD_3D_Mult", VC.Settings) MPnl[2]:AddItem(Sldr)   local Sldr = VC.Add_El_Slider("HUDHeight", 0, 100, 0, "How high on your screen the HUD will be on the right.", "HUD_Height", VC.Settings) List:AddItem(Sldr)   if vcmod1 then  local Sldr = VC.Add_El_Slider("PickupDistance", 0, 5000, 0, "Distance of which the pickup entity text is drawn.", "PickupDistance", VC.Settings) List:AddItem(Sldr)  local MPnl = VC.Add_El_Panel(List, {0.5,0.5}, 24, true)  local CBox = VC.Add_El_Checkbox("HUD_Name", "When entering a car the name of the car will appear on the bottom left of the screen.", "HUD_Name", VC.Settings) MPnl[1]:AddItem(CBox)  local Sldr = VC.Add_El_Slider("Height", 0, 1, 2, "How hight the vehicles name will be.", "HUD_Name_Height", VC.Settings) MPnl[2]:AddItem(Sldr)  local CBox = VC.Add_El_Checkbox("Health", "Indicator of the vehicles health on the middle right of the screen.", "HUD_Health", VC.Settings) List:AddItem(CBox)  local CBox = VC.Add_El_Checkbox("HUD_Icons", "Icons of what is active on the vehicle.", "HUD_Icons", VC.Settings) List:AddItem(CBox)  local MPnl = VC.Add_El_Panel(List, {0.5,0.5}, 24, true)  local CBox = VC.Add_El_Checkbox("HUD_Cruise", "Will show up when the cruise control is active, middle bottom of the screen.", "HUD_Cruise", VC.Settings) MPnl[1]:AddItem(CBox)  local CBox = VC.Add_El_Checkbox("HUD_MPH", "Show miles per hour instead of kilometers per hour.", "HUD_MPh", VC.Settings) MPnl[2]:AddItem(CBox)  local CBox = VC.Add_El_Checkbox("HUD_Repair", "This will show up when repairing a vehicle, middle bottom of the screen.", "HUD_Repair", VC.Settings) List:AddItem(CBox)  end  if vcmod1_els then  local CBox = VC.Add_El_Checkbox("HUD_ELS_Siren", "ELS HUD element, which will show the siren's.", "HUD_ELS_Siren", VC.Settings) List:AddItem(CBox)  local CBox = VC.Add_El_Checkbox("HUD_ELS_Lights", "ELS HUD element, which will show the light codes and sequences.", "HUD_ELS", VC.Settings) List:AddItem(CBox)  end   local Btn = vgui.Create("VC_Button") Btn:SetColor(VC.Color.Btn_Orn) Btn:SetSize(75, 20) Btn:SetPos(Pnl:GetWide()/2-35, Pnl:GetTall()-24) Btn:SetText(VC.Lng("Reset")) Btn:SetParent(Pnl) Btn:SetToolTip("Reset all settings to their default values.")  Btn.DoClick = function() VC.ResetSettings() if VC.Menu_Panel then VC.Menu_Panel.VC_Refresh_Panel = true end VCPopup("SettingsReset", "check") end   local X, Y = List:GetPos()  Pnl.Paint = function(obj, Sx, Sy)  draw.RoundedBox(0, X, Y, Sx, Sy, Color(0, 0, 0, 100))  draw.DrawText(VC.Lng("OptOnly_You"), "VC_Dev_Text", Sx/2, 5, VC.Color.Neutral, TEXT_ALIGN_CENTER)  end  return Draw end VC.Menu_Items_P.HUD = {"HUD", BuildMenu, Check = function() return VCMod1 or VCMod1_ELS end}  local function BuildMenu(Pnl)  local List = VC.Add_El_List(0, 35, Pnl:GetWide(), Pnl:GetTall()-35) List:SetParent(Pnl)   local MPnl = VC.Add_El_Panel(List, {0.5,0.5}, 32, true)  local ComboBox = vgui.Create("DComboBox", List) ComboBox:SetSize(200, 24)  ComboBox:AddChoice(VC.Lng("SuperAdmin")) ComboBox:AddChoice(VC.Lng("Administrator")) ComboBox:AddChoice(VC.Lng("NoneAdmin"))  ComboBox:ChooseOptionID(VC.PrivilagesLevel or 2)  ComboBox.OnSelect = function(idx, val) VC.SetPrivilages(val) end  local SNLbl = vgui.Create("DLabel") SNLbl:SetText(VC.Lng("AdminControlsCanBeAlteredBy"))  MPnl[1]:AddItem(SNLbl)  MPnl[2]:AddItem(ComboBox)   local Btn = vgui.Create("VC_Button") Btn:SetColor(VC.Color.Btn_Add) Btn:SetText(VC.Lng("Reload all addons, only serverside, players need to rejoin (warning, might be unstable)")) Btn:SetToolTip("Will cause the addon to reinitialize itself. This may cause instability or, even, errors.") List:AddItem(Btn)  Btn.DoClick = function() RunConsoleCommand("vc_update") end  local Btn = vgui.Create("VC_Button") Btn:SetColor(VC.Color.Btn_Spw) Btn:SetText(VC.Lng("Clear vehicle data cache, will cause to redownload")) Btn:SetToolTip("Clears any vehicle data information, redownloads if needed.") List:AddItem(Btn)  Btn.DoClick = function() RunConsoleCommand("vc_data_update") end  local Btn = vgui.Create("VC_Button") Btn:SetColor(VC.Color.Btn_Chn) Btn:SetText(VC.Lng("Check for language updates (done automatically every 6 hours)")) Btn:SetToolTip("Will check if there are any language updates available, if found, downloads them in the background.") List:AddItem(Btn)  Btn.DoClick = function() RunConsoleCommand("vc_lng_update") end   local X, Y = List:GetPos()  Pnl.Paint = function(obj, Sx, Sy)  draw.RoundedBox(0, X, Y, Sx, Sy, Color(0, 0, 0, 100))  draw.DrawText(VC.Lng("OptOnly_SuperAdmin"), "VC_Dev_Text", List:GetWide()/2, 5, VC.Color.Neutral, TEXT_ALIGN_CENTER)  end  return Draw end VC.Menu_Items_A.Menu = {"CoreOptions", BuildMenu, Check = function() return VCMod1 or VCMod1_ELS end} local rs7 = "vc.check_msg_work_ALS_k4" 