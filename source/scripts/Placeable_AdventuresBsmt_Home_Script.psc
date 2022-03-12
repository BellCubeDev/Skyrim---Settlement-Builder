Scriptname SSB_AdventuresBsmt_Home_Script extends ObjectReference  


Actor Property PlayerRef  Auto
ObjectReference Property TeleportMarker  Auto
ObjectReference Property ReturnMarker  Auto
ReferenceAlias Property Follower  Auto

Event OnActivate(ObjectReference akActionRef)
    ReturnMarker.MoveTo(PlayerRef)
    ReturnMarker.SetAngle(0.0,0.0,(Self.GetAngleZ()+180.00))
    akActionRef.MoveTo(TeleportMarker)
    Follower.GetActorRef().MoveTo(TeleportMarker)
EndEvent