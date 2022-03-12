Scriptname SSB_Catalogue_Workbench extends ObjectReference  


GlobalVariable Property CreativeMode  Auto
Actor Property PlayerRef  Auto
Spell Property SSB_CreativeMode_Catalouge_Spell  Auto


Event OnActivate(ObjectReference akActionRef)
  CreativeMode.SetValue(1.0)
  Utility.Wait(1.0)
  RegisterForSingleUpdate(0.5)
  
  
EndEvent
 
Event OnUpdate()
  If ( ! Game.IsLookingControlsEnabled() )
    RegisterForSingleUpdate(0.5)
    return
  Else 
    CreativeMode.SetValue(0.0)
    Cast()
EndIf
EndEvent

Function Cast()
SSB_CreativeMode_Catalouge_Spell.Cast( PlayerRef)
EndFunction

