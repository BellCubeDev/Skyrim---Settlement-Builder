Scriptname Placeable_Firewood_Script extends ObjectReference  


Activator Property Firewood01  Auto 

Event OnActivate(ObjectReference akActionRef)

Self.PlaceAtMe(Firewood01)


self.Disable(True)
Self.Deletewhenable()
Self.Delete()
EndEvent
