
-----------------------------------------------------
--[[
	Name: food_clerk.lua
	For: SantosRP
	By: Ultra
]]--

local NPCMeta = {}
NPCMeta.Name = "Store Clerk"
NPCMeta.UID = "food_clerk"
NPCMeta.SubText = "Purchase items here"
NPCMeta.Model = "models/Humans/Group02/Female_02.mdl"
NPCMeta.Sounds = {
	StartDialog = {
		"vo/npc/female01/hi01.wav",
		"vo/npc/female01/hi02.wav",
		"vo/npc/female01/gordead_ques16.wav",
		"vo/npc/female01/answer30.wav",
	},
	EndDialog = {
		"vo/npc/female01/pardonme01.wav",
		"vo/npc/female01/pardonme02.wav",
		"vo/npc/female01/answer15.wav",
		"vo/npc/female01/excuseme02.wav",
		"vo/npc/female01/excuseme01.wav",
	}
}
--[itemID] = priceToBuy,
NPCMeta.ItemsForSale = {
	--ents
	["Cooking Pot"] = 45,
	["Coffee Maker"] = 100,
	["Food-Prep Table"] = 500,

	--fluids
	["Vinegar"] = 13,
	["Filtered Water"] = 6,
	["Jo Jo's Cola"] = 13,
	["Sprunk Cola"] = 13,
	["Orange Juice"] = 10,
	["Milk"] = 12,
	["Salt"] = 8,
	["Cooking Oil"] = 10,
	["Ground Coffee"] = 10,
	["Sugar"] = 9,
	
	["Red Wine"] = 16,
	["White Wine"] = 16,
	["Champagne"] = 16,

	--items
	["Aluminum Foil"] = 15,
	["Uncooked Beef"] = 5,
	["Uncooked Bacon"] = 8,
	["Uncooked Bass"] = 9,
	["Uncooked Catfish"] = 9,
	["Uncooked Rainbow Trout"] = 9,
	["Uncooked Lobster"] = 12,
	["Doritos - Nacho Cheese"] = 6,
	["Fritos - Original"] = 6,
	["Fritos - BBQ"] = 7,
	["Fritos - BBQ Hoops"] = 7,
	["Lays - Classic"] = 6,
	["Lays - Salt & Vinegar"] = 6,
	["Lays - Barbecue"] = 6,
	["Lays - Sour Cream & Onion"] = 7,
	["Lays - Dill Pickle"] = 7,
	["Lays - Flamin' Hot"] = 7,
	["Apple Jacks"] = 12,
	["Honey Nut Cheerios"] = 12,
	["Corn Flakes"] = 12,
	["Panda Puffs"] = 12,
	["Frosted Mini-Wheats"] = 12,
	["Toblerone"] = 6,
	["Jar of Pickles"] = 5,
	["Kinder Surprise"] = 6,
	["Cookies"] = 9,
	["Watermelon"] = 14,
	["Orange"] = 4,
	["Banana"] = 5,
	["Bunch of Bananas"] = 16,
	["Wheat Bread"] = 2,
	["Potato"] = 2,
	["Egg"] = 5,
	["Cheese"] = 2,
	["Lettuce"] = 7,
	["Box of Flour"] = 10,

	["Uncooked Steak"] = 12,
	["Tomato"] = 3,
	["Carrot"] = 3,
	["Red Apple"] = 3,
	["Green Apple"] = 3,
	["Pear"] = 4,
	["Pineapple"] = 5,
	["Baguette"] = 7,

}
--[itemID] = priceToSell,
NPCMeta.ItemsCanBuy = {
	["Toast (Disgusting Quality)"] = 1,
	["Toast (Average Quality)"] = 5,
	["Toast (Delicious Quality)"] = 10,

	["Cake (Disgusting Quality)"] = 20,
	["Cake (Average Quality)"] = 85,
	["Cake (Delicious Quality)"] = 150,

	["Cooked Bacon (Disgusting Quality)"] = 4,
	["Cooked Bacon (Average Quality)"] = 15,
	["Cooked Bacon (Delicious Quality)"] = 27,

	["Cooked Lobster (Disgusting Quality)"] = 8,
	["Cooked Lobster (Average Quality)"] = 24,
	["Cooked Lobster (Delicious Quality)"] = 42,

	["Cooked Bass (Disgusting Quality)"] = 5,
	["Cooked Bass (Average Quality)"] = 19,
	["Cooked Bass (Delicious Quality)"] = 38,

	["Cooked Catfish (Disgusting Quality)"] = 5,
	["Cooked Catfish (Average Quality)"] = 19,
	["Cooked Catfish (Delicious Quality)"] = 38,

	["Cooked Rainbow Trout (Disgusting Quality)"] = 5,
	["Cooked Rainbow Trout (Average Quality)"] = 19,
	["Cooked Rainbow Trout (Delicious Quality)"] = 38,

	["Cheese Burger (Disgusting Quality)"] = 5,
	["Cheese Burger (Average Quality)"] = 18,
	["Cheese Burger (Delicious Quality)"] = 35,

	["Double Cheese Burger (Disgusting Quality)"] = 10,
	["Double Cheese Burger (Average Quality)"] = 27,
	["Double Cheese Burger (Delicious Quality)"] = 60,

	["Cheese Steak (Disgusting Quality)"] = 8,
	["Cheese Steak (Average Quality)"] = 24,
	["Cheese Steak (Delicious Quality)"] = 42,

	["French Fries (Disgusting Quality)"] = 4,
	["French Fries (Average Quality)"] = 17,
	["French Fries (Delicious Quality)"] = 32,
}
for k, v in pairs( NPCMeta.ItemsForSale ) do
	NPCMeta.ItemsCanBuy[k] = math.ceil( v *0.66 )
end

function NPCMeta:OnPlayerTalk( entNPC, pPlayer )
	GAMEMODE.Net:ShowNPCDialog( pPlayer, "club_foods_clerk" )
	
	if (entNPC.m_intLastSoundTime or 0) < CurTime() then
		local snd, _ = table.Random( self.Sounds.StartDialog )
		entNPC:EmitSound( snd, 60 )
		entNPC.m_intLastSoundTime = CurTime() +2
	end
end

function NPCMeta:OnPlayerEndDialog( pPlayer )
	if not pPlayer:WithinTalkingRange() then return end
	if pPlayer:GetTalkingNPC().UID ~= self.UID then return end

	if (pPlayer.m_entTalkingNPC.m_intLastSoundTime or 0) < CurTime() then
		local snd, _ = table.Random( self.Sounds.EndDialog )
		pPlayer.m_entTalkingNPC:EmitSound( snd, 60 )
		pPlayer.m_entTalkingNPC.m_intLastSoundTime = CurTime() +2
	end

	pPlayer.m_entTalkingNPC = nil
end

if SERVER then
	--RegisterDialogEvents is called when the npc is registered! This is before the gamemode loads so GAMEMODE is not valid yet.
	function NPCMeta:RegisterDialogEvents()
	end
elseif CLIENT then
	function NPCMeta:RegisterDialogEvents()
		GM.Dialog:RegisterDialog( "club_foods_clerk", self.StartDialog, self )
	end
	
	function NPCMeta:StartDialog()
		GAMEMODE.Dialog:ShowDialog()
		GAMEMODE.Dialog:SetModel( self.Model )
		GAMEMODE.Dialog:SetTitle( self.Name )
		GAMEMODE.Dialog:SetPrompt( "You gonna buy something pal?" )

		GAMEMODE.Dialog:AddOption( "Show me what you have for sale.", function()
			GAMEMODE.Gui:ShowNPCShopMenu( self.UID )
			GAMEMODE.Dialog:HideDialog()
		end )
		GAMEMODE.Dialog:AddOption( "I would like to return some items.", function()
			GAMEMODE.Gui:ShowNPCSellMenu( self.UID )
			GAMEMODE.Dialog:HideDialog()
		end )
		GAMEMODE.Dialog:AddOption( "Never mind, I have to go.", function()
			GAMEMODE.Net:SendNPCDialogEvent( self.UID.. "_end_dialog" )
			GAMEMODE.Dialog:HideDialog()
		end )
	end
end

GM.NPC:Register( NPCMeta )