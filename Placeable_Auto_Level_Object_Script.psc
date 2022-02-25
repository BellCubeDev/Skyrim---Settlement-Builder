Scriptname SSB_Auto_Level_Object_Script extends ActiveMagiceffect  

GlobalVariable Property SSB_Auto_Leveling_Items  Auto
{Global that tracks whether auto-leveling is enabled}

Message Property SSB_Auto_Leveling_Enabled_MSG  Auto
{Message to show when auto-leveling is enabled}

Message Property SSB_Auto_Leveling_Disabled_MSG  Auto
{Message to show when auto-leveling is disabled}


Event OnEffectStart(Actor akTarget, Actor akCaster)
;Debug.Notification("Auto Level Object - ("+SSB_Auto_Leveling_Items.GetValueInt()+")")
Debug.Trace("[LVX-SSS] Auto Level Object - ("+SSB_Auto_Leveling_Items.GetValueInt()

If (SSB_Auto_Leveling_Items.GetValue() == 0.0)
        SSB_Auto_Leveling_Items.SetValue(1.0) 
        Debug.Notification("Auto Level Object - (Off)") 
        Debug.Trace("[LVX-SSS] Auto Level Object - (Off)
    Else
        SSB_Auto_Leveling_Items.SetValue(0.0) 
        Debug.Notification("Auto Level Object - (On)") 
        Debug.Trace("[LVX-SSS] Auto Level Object - (On)
    EndIf

EndEvent
