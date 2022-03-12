Scriptname SSB_Creative_Catalogue_Book extends ObjectReference  


Spell Property SSB_CreativeMode_Catalouge_Spell  Auto
Actor Property PlayerRef  Auto
MiscObject Property Catalogue  Auto
Message Property SSB_ManualMenu_CreativeMode_Catalogue  Auto
Event OnEquipped(Actor akActor)
  If akActor == Game.GetPlayer()
  Debug.Notification("Leave Inventory to Use Catalogue")
  Debug.Trace("[LVX-SSS] Leave Inventory to Use Catalogue")
   Utility.Wait(0.1)
   Cast() 
EndIf
EndEvent



;----------------------------------------------------------------------------------------------
;MAIN MENU
;---------------------------------------------------------------------------------------------


Function Cast()
SSB_CreativeMode_Catalouge_Spell.Cast(PlayerRef)
EndFunction


