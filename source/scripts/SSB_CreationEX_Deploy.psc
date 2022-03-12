Scriptname SSB_CreationEX_Deploy extends ObjectReference 

Activator Property ActivatorEX_Act  Auto

Event OnActivate(ObjectReference akActionRef)

 DisableNoWait(True)
   Self.Disable(True)
   Self.PlaceatMe(ActivatorEX_Act)       
   Self.DeleteWhenAble()
   DeleteWhenAble()
   Delete()
  
EndEvent 

 
