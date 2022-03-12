Scriptname SSB_KeyMaster_Script extends ObjectReference  



ObjectReference Property Door01  Auto
ObjectReference Property Door02  Auto
ObjectReference Property Door03  Auto
ObjectReference Property Door04  Auto
{The door to lock}


String Property LOCKMESSAGE  Auto
{The notification to when the door is locked}



Event OnEquipped(Actor akActor)

    Int OpenState = Door01.GetOpenState()
                                  Door02.GetOpenState()
                                  Door03.GetOpenState()
                                  Door04.GetOpenState()

       

    If (OpenState == 1 || OpenState == 2)

        debug.notification(LOCKMESSAGE)

        Debug.Trace("[LVX-SSS] " + LOCKMESSAGE)
        Door01.Activate(Game.GetPlayer())
             Door02.Activate(Game.GetPlayer())
             Door03.Activate(Game.GetPlayer())
             Door04.Activate(Game.GetPlayer())

        Utility.Wait(1.5)
        Door01.Lock()
             Door02.Lock()
             Door03.Lock()
             Door04.Lock()


    Else

        debug.notification(LOCKMESSAGE)

        Debug.Trace("[LVX-SSS] " + LOCKMESSAGE)
        Door01.Lock()
             Door02.Lock()
             Door03.Lock()
             Door04.Lock()


    EndIf

EndEvent
