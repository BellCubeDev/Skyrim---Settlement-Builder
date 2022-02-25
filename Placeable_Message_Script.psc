Scriptname SSB_Message_Script extends ObjectReference  

{Show a message or notification on activate with the option of having this happen only once.}


;Original universal script created by Darkfox127
;Any potential problems which may arise from this script being changed from the original are the sole responsibility of the mod author making the changes.
;Please be sure to credit If you this in your own published mod.


Bool Property  DONE  Auto hidden

Bool Property doOnce = False Auto
{Set to True If you wish this message to only show once.

Default = False}

Bool Property CustomMsg = False Auto
{Set to True If you wish to a Mesage pr-created in the Creation Kit.

Default = False}

Bool Property MsgBox = True Auto
{Set to False If you wish to show a notification.

Default = True}

Message Property MyMessage  Auto
{Your custom message you will be using.}

String Property Text  Auto
{Type your message to show here.}



Event OnActivate(ObjectReference akActionRef)

    If doOnce == True

        If DONE == False

            ShowMessage()
            DONE = True

        Else

            ;Do Nothing
            Return

        EndIf

    Else

        ShowMessage()

    EndIf

EndEvent



Function ShowMessage()

    If CustomMsg == True
        MyMessage.show()
    Else
        If MsgBox == True
            debug.messagebox(Text)
        Else
            debug.notification(Text)
            Debug.Trace("[LVX-SSS] " + Text)
        EndIf
    EndIf

EndFunction