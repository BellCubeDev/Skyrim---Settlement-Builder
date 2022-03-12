Scriptname SSB_ClutterExtension_Script extends ObjectReference 

 


Activator Property Clutter01  Auto 
MiscObject Property MiscObj01  Auto


Event OnActivate(ObjectReference akActionRef)

Self.PlaceAtMe(Clutter01)


self.Disable(True)
Self.Deletewhenable()
Self.Delete()
EndEvent
 
