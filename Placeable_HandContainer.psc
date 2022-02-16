Scriptname Placeable_HandContainer extends ObjectReference  

Message Property My_InventoryContainer_Message  Auto
Spell Property Handheld_Container_Spell  Auto
Actor Property PlayerRef  Auto



Event OnEquipped(Actor akActor)
  If akActor == Game.GetPlayer()
  My_InventoryContainer_Message.Show()
   Utility.Wait(0.1)
   Cast() 
EndIf
EndEvent



;----------------------------------------------------------------------------------------------
;MAIN MENU
;---------------------------------------------------------------------------------------------


Function Cast()
Handheld_Container_Spell.Cast(PlayerRef)
EndFunction


