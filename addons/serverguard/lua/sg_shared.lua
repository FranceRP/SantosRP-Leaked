
-----------------------------------------------------
--[[
	� 2016 Thriving Ventures Ltd do not share, re-distribute or modify
	without permission of its author (gustaf@thrivingventures.com).
]]

--- ## Shared
-- Global library that holds all other libraries, and various small helper functions.
-- @module serverguard

serverguard.version = "1.7.2";
serverguard.latestVersion = serverguard.version;

SERVERGUARD.ENDPOINT = "http://api.gmodserverguard.com/api/";

SERVERGUARD.NETWORK = {};
SERVERGUARD.NETWORK.NUMBER = 1;
SERVERGUARD.NETWORK.STRING = 2;
SERVERGUARD.NETWORK.BOOLEAN = 3;
SERVERGUARD.NETWORK.DECODE = 4;
SERVERGUARD.NETWORK.COLOR = 5;
SERVERGUARD.NETWORK.CUSTOM = 6;

--- Enumeration table to specify notify colour.
-- @field RED Red colour.
-- @field WHITE White colour.
-- @field GREEN Green colour.
-- @see serverguard.Notify
SERVERGUARD.NOTIFY = {};
SERVERGUARD.NOTIFY.DEFAULT = 1;
SERVERGUARD.NOTIFY.RED = 2;
SERVERGUARD.NOTIFY.WHITE = 3;
SERVERGUARD.NOTIFY.GREEN = 4;

--- Enumeration table to specify file state.
-- @field SERVER Server state.
-- @field CLIENT Client state.
-- @field SHARED Server and client state.
-- @see serverguard.ParseFile
SERVERGUARD.STATE = {};
SERVERGUARD.STATE.SERVER = 1;
SERVERGUARD.STATE.CLIENT = 2;
SERVERGUARD.STATE.SHARED = 3;

--- Enumeration table to specify immunity comparisons.
-- @field EQUAL Immunities are equal.
-- @field LESS Target immunity is less than the given one.
-- @field LESSOREQUAL Target immunity is less than or equal to the given one.
-- @field ANY Any immunity works.
-- @see util.FindPlayers
SERVERGUARD.IMMUNITY = {};
SERVERGUARD.IMMUNITY.EQUAL = 1; -- not sure why you would explicitly need equal immunity, but it's here anyway
SERVERGUARD.IMMUNITY.LESS = 2;
SERVERGUARD.IMMUNITY.LESSOREQUAL = 3;
SERVERGUARD.IMMUNITY.ANY = 4;

--- Returns the version of this server's copy of ServerGuard.
-- @treturn string Version number with format `#.#.#`.
function serverguard.GetCurrentVersion()
	return serverguard.version;
end;

--- Returns the latest version of ServerGuard. This could be incorrect,
-- as the server has to wait for the HTTP request to complete.
-- @treturn string Version number with format `#.#.#`.
function serverguard.GetLatestVersion()
	return serverguard.latestVersion;
end;

--- Prints to console with the time and a `[ServerGuard]` prefix.
-- @string text The text to print to the console.
function serverguard.PrintConsole(text)
	Msg("[" .. os.date("%H:%M") .. "][ServerGuard] " .. text);
end;

serverguard.NotifyColors = {};
serverguard.NotifyColors[SERVERGUARD.NOTIFY.DEFAULT]	= Color(230, 230, 230); -- For backwards compatibility.
serverguard.NotifyColors[SERVERGUARD.NOTIFY.RED] 		= Color(211, 78, 71);
serverguard.NotifyColors[SERVERGUARD.NOTIFY.WHITE] 		= Color(230, 230, 230);
serverguard.NotifyColors[SERVERGUARD.NOTIFY.GREEN]		= Color(55, 163, 68);

--- Includes files based on their state (client, server, shared).
-- @string filePath The file to parse.
-- @state state State enumeration to specify how to parse it.
-- @usage serverguard.ParseFile("tools/sv_administration.lua", SERVERGUARD.STATE.SERVER);
function serverguard.ParseFile(filePath, state)
	if (state == SERVERGUARD.STATE.SHARED) then
		if (SERVER) then
			AddCSLuaFile(filePath);
		end;
		
		include(filePath);
		
		if (SG_DEBUG or SG_FILE_DEBUG) then
			serverguard.PrintConsole("Loaded shared file: " .. filePath .. ".\n");
		end;
	else
		if (state == SERVERGUARD.STATE.CLIENT) then
			if (SERVER) then
				AddCSLuaFile(filePath);
			elseif (CLIENT) then
				include(filePath);
			end;
			
			if (SG_DEBUG or SG_FILE_DEBUG) then
				serverguard.PrintConsole("Loaded clientside file: " .. filePath .. ".\n");
			end;
		end;
		
		if (state == SERVERGUARD.STATE.SERVER and SERVER) then
			include(filePath);
			
			if (SG_DEBUG or SG_FILE_DEBUG) then
				serverguard.PrintConsole("Loaded serverside file: " .. filePath .. ".\n");
			end;
		end;
	end;
end;

serverguard.ParseFile("modules/sh_von.lua", 		SERVERGUARD.STATE.SHARED);
serverguard.ParseFile("modules/sh_netstream.lua",	SERVERGUARD.STATE.SHARED);

--- Sends a message in a player's chat box. Set player to nil or LocalPlayer() when using clientside.
-- @player player The player to send the notification to. Specify nil to send to everyone.
-- @param ... Any notify enumeration followed by text.
-- @usage serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, "This", SERVERGUARD.NOTIFY.WHITE, " is a test.");
function serverguard.Notify(player, ...)
	local arguments = {...};
	local text = "";

	for k, v in pairs(arguments) do
		if (type(v) == "number") then
			if (serverguard.NotifyColors[v] == nil) then
				arguments[k] = SERVERGUARD.NOTIFY.DEFAULT;
			end;
		elseif (type(v) == "string") then
			text = text .. v;
		else
			table.remove(v);
		end;
	end;

	if (type(arguments[1]) != "number") then
		table.insert(arguments, 1, SERVERGUARD.NOTIFY.DEFAULT);
	end;

	if (SERVER) then
		if (IsValid(player)) then
			serverguard.netstream.Start(player, "sgNotifyText", arguments);
		else
			serverguard.netstream.Start(nil, "sgNotifyText", arguments);
			serverguard.PrintConsole(string.format("%s\n", text));
		end;
	elseif (CLIENT) then
		for k, v in pairs(arguments) do
			if (type(v) == "number") then
				arguments[k] = serverguard.NotifyColors[v];
			end;
		end;

		chat.AddText(unpack(arguments));
	end;
end;

if (CLIENT) then
	serverguard.netstream.Hook("sgNotifyText", function(data)
		local arguments = {};

		for k, v in pairs(data) do
			if (type(v) == "number") then
				arguments[#arguments + 1] = serverguard.NotifyColors[v];
			elseif (type(v) == "string") then
				arguments[#arguments + 1] = v;
			end;
		end;

		chat.AddText(unpack(arguments));
	end);

	serverguard.netstream.Hook("sgPopupError", function(data)
		if (type(data) == "string") then
			util.CreateDialog("Error", data, function() end, "Close");
		end;
	end);

	serverguard.contextRegistry = {};
	
	function serverguard:RegisterContextMenu(callback)
		table.insert(serverguard.contextRegistry, callback);
	end;
end;

serverguard.ParseFile("modules/sh_phrase.lua",						SERVERGUARD.STATE.SHARED);
serverguard.ParseFile("modules/sh_permissions.lua", 				SERVERGUARD.STATE.SHARED);
serverguard.ParseFile("modules/sh_utilities.lua", 					SERVERGUARD.STATE.SHARED);
serverguard.ParseFile("modules/sh_player.lua", 						SERVERGUARD.STATE.SHARED);
serverguard.ParseFile("modules/sv_player.lua", 						SERVERGUARD.STATE.SHARED);
serverguard.ParseFile("modules/sh_commands.lua", 					SERVERGUARD.STATE.SHARED);
serverguard.ParseFile("modules/sv_mysql.lua", 						SERVERGUARD.STATE.SERVER);
serverguard.ParseFile("modules/sh_cami.lua", 						SERVERGUARD.STATE.SHARED);
serverguard.ParseFile("modules/sh_ranks.lua", 						SERVERGUARD.STATE.SHARED);
serverguard.ParseFile("modules/cl_themes.lua",						SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/derma_skin.lua",					SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/controls/tiger_base.lua",		SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/controls/tiger_scrollpanel.lua",	SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/controls/tiger_divider.lua",		SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/controls/tiger_list.lua",		SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/controls/tiger_panel.lua",		SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/controls/tiger_button.lua",		SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/controls/tiger_tooltip.lua",		SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/controls/tiger_linegraph.lua",	SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/controls/tiger_news.lua",		SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/controls/tiger_dialog.lua",		SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/controls/tiger_checkbox.lua",	SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/controls/tiger_numslider.lua",	SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/controls/tiger_textentry.lua",	SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/controls/tiger_combobox.lua",	SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/menu.lua", 						SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/news.lua", 						SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/manage_players.lua", 			SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/command_list.lua", 				SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/ban_list.lua", 					SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/rank_list.lua", 					SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/rank_editor.lua", 				SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/gui/themes.lua", 					SERVERGUARD.STATE.CLIENT);
serverguard.ParseFile("modules/sh_config.lua", 						SERVERGUARD.STATE.SHARED);
serverguard.ParseFile("modules/sh_plugin.lua", 						SERVERGUARD.STATE.SHARED);
serverguard.ParseFile("modules/sv_spectate.lua", 					SERVERGUARD.STATE.SERVER);

serverguard.ParseFile("tools/sv_ranks.lua", 			SERVERGUARD.STATE.SERVER);
serverguard.ParseFile("tools/sv_administration.lua", 	SERVERGUARD.STATE.SERVER);
serverguard.ParseFile("tools/sh_commands.lua", 			SERVERGUARD.STATE.SHARED);