Scriptname SSB_BootsOBlind_Script extends ObjectReference  

Actor Property PlayerRef  Auto
Message Property DebugNotification  Auto
ImageSpaceModifier Property BootsOBlind  Auto


Event OnEquipped(Actor akActor)
  
  If akActor == PlayerRef
    BootsOBlind.Apply()
    PlayerRef.ModActorValue("SpeedMult", 1000.0) 
    PlayerRef.ModActorValue("CarryWeight", 0.1)
  EndIf

EndEvent


Event OnUnequipped(Actor akActor)

  BootsOBlind.Remove()
  PlayerRef.ModActorValue("SpeedMult", -1000.0) 
  PlayerRef.ModActorValue("CarryWeight", -0.1) 

EndEvent
