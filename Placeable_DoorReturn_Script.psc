Scriptname SSB_DoorReturn_Script extends ObjectReference  


ObjectReference Property ReturnMarker  Auto
ReferenceAlias Property Follower  Auto

Event OnActivate(ObjectReference akActionRef)
    akActionRef.MoveTo(ReturnMarker)
    Follower.GetActorRef().MoveTo(ReturnMarker)
EndEvent