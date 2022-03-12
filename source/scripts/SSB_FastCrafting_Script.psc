Scriptname SSB_FastCrafting_Script extends activemagiceffect  


ObjectReference Property CraftingStation  Auto


Event OnEffectStart(Actor akTarget, Actor akCaster)

 
  CraftingStation.Activate(Game.GetPlayer())

EndEvent