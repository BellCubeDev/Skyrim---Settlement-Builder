Scriptname SSB_Flora_Timer_Script02 extends ObjectReference  



Flora Property Plant01  Auto
Int Property iResetHours = 72 Auto

Event OnActivate(ObjectReference akActionRef) 
RegisterForSingleUpdateGameTime(iResetHours)
EndEvent

Event OnUpdateGameTime()
Self.Disable()
Self.Delete()
ObjectReference NewPlant = Self.PlaceAtMe(Plant01) 
 (Self.Enable())

EndEvent