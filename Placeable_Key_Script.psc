Scriptname Placeable_Key_Script extends ObjectReference  



;Original universal script created by Darkfox127
;Any potential problems which may arise from this script being changed from the original are the sole responsibility of the mod author making the changes.
;Please be sure to credit If you this in your own published mod.


ObjectReference Property Door01  Auto
{The door to lock}


String Property LOCKMESSAGE  Auto
{The notification to when the door is locked}



Event OnEquipped(Actor akActor)

    Int OpenState = Door01.GetOpenState()

    If (OpenState == 1 || OpenState == 2)

        debug.notification(LOCKMESSAGE)

        Debug.Trace("[LVX-SSS] " + LOCKMESSAGE)
        Door01.Activate(Game.GetPlayer())
        Utility.Wait(1.5)
        Door01.Lock()

    Else

        debug.notification(LOCKMESSAGE)

        Debug.Trace("[LVX-SSS] " + LOCKMESSAGE)
        Door01.Lock()

    EndIf

EndEvent
