Scriptname Placeable_Message_OnStart extends ReferenceAlias  


Bool Property doOnce = True Auto

Event Oninit()
Utility.Wait(3.0)
Debug.Notification("Options: Settlement Builder: To Start Building")
Debug.Trace("[LVX-SSS] Options: Settlement Builder: To Start Building")
EndEvent
