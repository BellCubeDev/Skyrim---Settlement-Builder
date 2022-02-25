Scriptname SSB_CreativeMode_Toggle extends activemagiceffect  


ObjectReference Property CraftingStation  Auto


Event OnEffectStart(Actor akTarget, Actor akCaster)
CraftingStation.Activate(Game.GetPlayer())




EndEvent
 