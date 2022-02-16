Scriptname Placeable_Flora_Timer_Script extends ObjectReference  

import game
import debug



Flora Property Plant01  Auto
Int Property iResetHours = 72 Auto

Event OnActivate(ObjectReference akActionRef)
RegisterForSingleUpdateGameTime(iResetHours)
EndEvent

Event OnUpdateGameTime()
    
Self.Disable()
Self.Placeatme(Plant01)
Self.additem(Plant01)
Self.DeleteWhenAble()

EndEvent
