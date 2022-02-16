Scriptname Placeable_UseBedroll_Script extends ObjectReference  

ObjectReference Property Bedroll  Auto


Event OnActivate(ObjectReference AkActionRef)
Bedroll.Activate(Game.GetPlayer())

EndEvent