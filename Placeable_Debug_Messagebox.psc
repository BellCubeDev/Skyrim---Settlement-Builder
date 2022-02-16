Scriptname Placeable_Debug_Messagebox extends ObjectReference  
String Property MyMessage  Auto
{Shows the Quick Messagebox On Load}
Message Property SSB_AAA_UndertandCupsMenuUI  Auto
GlobalVariable Property SSB_Global_IUnderstand01  Auto
{Shows the Aggrement Message }

Bool Property doOnce = True Auto


Event Onload()

If (Mymessage) 
Utility.Wait(0.5)

Debug.Messagebox(MyMessage) ; Fast string message
 Else 

If (Placeable_Global_IUnderstand01.GetValue() == 0.0)
 Menu()
 
 EndIf
 EndIf     
EndEvent


Function Menu(Int aiButton = 0)
     aiButton = Placeable_AAA_UndertandCupsMenuUI.show() ; Actual agreement Menu

    If aiButton == 0
    ;Ok

    ElseIf aiButton == 1
    ;I understand

    Placeable_Global_IUnderstand01.SetValue(1.0)

    EndIf
EndFunction
    