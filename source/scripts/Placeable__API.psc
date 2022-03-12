Scriptname SSB_API Extends Quest
{Script attached to the Placeable API Quest. Privodes API functions for general Settlement Building use.}

Actor Property PlayerREf  Auto

; Globals

GlobalVariable Property SSB_Positioner_SKSE_Global  Auto
GlobalVariable Property SSB_AutoLevel_Disabled  Auto ; Defualt = (1.0)

; Messages

Message Property SSB_MenuUI_Main  Auto
Message Property SSB_MenuUi_Main_SKSE  Auto

Message Property SSB_MenuUi_MakeStatic  Auto
Message Property SSB_MenuUi_MakeStatic_SKSE  Auto

Message Property SSB_MenuUi_Options  Auto
Message Property SSB_MenuUi_Options_SKSE  Auto

Message Property SSB_MenuUi_Options_PositionerMenu  Auto
Message Property SSB_MenuUi_Options_PositionerMenu_SKSE  Auto

Message Property SSB_MenuUi_Z_Pos  Auto
Message Property SSB_MenuUi_Z_Pos_SKSE  Auto

Message Property SSB_MenuUi_Y_Pos  Auto
Message Property SSB_MenuUi_Y_Pos_SKSE  Auto

Message Property SSB_MenuUi_X_Pos  Auto
Message Property SSB_MenuUi_X_Pos_SKSE  Auto

Message Property SSB_MenuUi_Z_Rotate  Auto
Message Property SSB_MenuUi_Z_Rotate_SKSE  Auto

Message Property SSB_MenuUi_Switch_Save  Auto


;/
MiscObject property MiscObj  Auto

Static Property StaticDummy  Auto
Activator Property My_Activator_Static  Auto
/;

; Spells (for some reason)
Spell Property SSB_SKSE_Positioner_Toggle  Auto
Spell Property SSB_Auto_Level_Object_Global_Toggle_Spell  Auto

;/BELL:
        This property will, whenever accessed, check if SKSE is enabled and should be used.
        Auto simply handles all of the Get/Set functions for you, however you can define them yourself
        if you ommit Auto. If you ommit Auto and do not define one of the functions, then that action will be inaccessible.
        In this case, getting UseSKSE will return a bool saying whether or not SKSE should be used

        If you don't have a Get function, scripts won't be able to retrieve the value!
        And if Set isn't defined, users can't write to the property.

        Because I have the Hidden flag set, it won't show up in the CK, either.
/; ; And yes, I'm using long comments now.

Bool Property UseSKSE Hidden ; ReadOnly
    Bool Function Get()
        ;                                                         Thanks Pickysaurus!
        return SSB_Positioner_SKSE_Global.GetValue() == 0.0 && SKSE.GetVersionRelease() && (SKSE.GetVersionRelease() == SKSE.GetScriptVersionRelease())
        ;      Does the user want it?                             Is working in the engine?      Does the version stored in the script match the version in the engine?
    EndFunction
EndProperty

; Same tech used to check if we should do auto-leveling.
; However here, we have a Set() here too. Makes it easy for us.
; This is what we call a "wrapper"
Bool Property DoAutoLevel Hidden ; ReadOnly
    Bool Function Get()
        ; Casting an Int or a Float to a Bool checks if the value is non-zero. In this use case, any non-zero value will disable Auto-leveling.
        return !SSB_AutoLevel_Disabled.GetValue()
    EndFunction
    Function Set(Bool abNewValue)
        ; Sets the Global to 0.0 if we're not disabling, and 1.0 if we are.
        SSB_AutoLevel_Disabled.SetValue((!abNewValue) as Float)
    EndFunction
EndProperty




;/$$$$$$$\ $$\       $$\             $$\           $$\      $$\                     $$\
 $$  _____|$$ |      \__|            $$ |          $$$\    $$$ |                    \__|
 $$ |      $$ |      $$\  $$$$$$$\ $$$$$$\         $$$$\  $$$$ | $$$$$$\   $$$$$$\  $$\  $$$$$$$\
 $$$$$\    $$ |      $$ |$$  _____|\_$$  _|        $$\$$\$$ $$ | \____$$\ $$  __$$\ $$ |$$  _____|
 $$  __|   $$ |      $$ |\$$$$$$\    $$ |          $$ \$$$  $$ | $$$$$$$ |$$ /  $$ |$$ |$$ /
 $$ |      $$ |      $$ | \____$$\   $$ |$$\       $$ |\$  /$$ |$$  __$$ |$$ |  $$ |$$ |$$ |
 $$ |      $$$$$$$$\ $$ |$$$$$$$  |  \$$$$  |      $$ | \_/ $$ |\$$$$$$$ |\$$$$$$$ |$$ |\$$$$$$$\
 \__|      \________|\__|\_______/    \____/       \__|     \__| \_______| \____$$ |\__| \_______|
                                                                          $$\   $$ |
                                                                          \$$$$$$  |
                                                                           \______/;


; Saving
GlobalVariable Property SSB_CurrentSave  Auto


; MORE fancy Property tech?! (I need to start using this in my own scripts)
Int Property CurrentSaveNum Hidden
    Int Function Get()
        return SSB_CurrentSave.GetValue() as Int
    EndFunction

    Function Set(Int aiNewValue)
        ; Checks if there would indeed be a save list with the new value before setting it
        If SSB_SaveLists_All[aiNewValue]
            SSB_CurrentSave.SetValue(aiNewValue as Float)
        EndIf
    EndFunction
EndProperty

FormList Property currentSaveList Hidden ; ReadOnly
    FormList Function Get()
        return SSB_SaveLists_All[CurrentSaveNum]
    EndFunction
EndProperty

FormList[] Property SSB_SaveLists_Enabled  Auto
{FormLists used to hold saved layouts. These lists only includes enabled items.
Fill with 9 empty lists.}

FormList[] Property SSB_SaveLists_All  Auto
{FormLsts used to hold saved layouts. These lists include all items.
Fill with 9 empty-in-plugin lists.}


; Tracking (for viewable stats, deletion, etc.)

; Permanent/Temporary Tracking
FormList Property SSB_TrackingList_Permanent  Auto
{Tracks all permanent objects}
FormList Property SSB_TrackingList_Temporary  Auto
{Tracks all non-permanent objects}

; Enabled/Disabled Tracking
FormList Property SSB_TrackingList_Enabled  Auto
{Tracks all enabled objects}
FormList Property SSB_TrackingList_Disabled  Auto
{Tracks all disabled objects}

; Everything Tracking
FormList Property SSB_TrackingList_All  Auto

; Form Type Tracking
FormList Property SSB_TrackingList_Statics  Auto
{Tracks all Statics (ignores permenance)}
FormList Property SSB_TrackingList_Activators  Auto
{Tracks all Actovators (ignores permenance)}
FormList Property SSB_TrackingList_Lights  Auto
{Tracks all Lights (ignores permenance)}


; Adds an object to its appropriate FormLists. DRY!
;
; abIsPermanent: Is this a "permanent" object?
; abAutoDetect:  Will attempt to auto-detect the list the object goes into
; aiType:        Manually set which type the object is.
;                1 - Static
;                2 - Activator
;                3 - Light
;
Function AddObjectToLists(ObjectReference akObject, Bool abIsPermanent, Bool abAutoDetect = true, int aiType = 0)

    SSB_TrackingList_All.AddForm(akObject)
    SSB_SaveLists_All[SSB_CurrentSave.GetValueInt()].AddForm(akObject)

    If akObject.IsEnabled()
        SSB_TrackingList_Enabled.AddForm(akObject)
        SSB_SaveLists_Enabled[SSB_CurrentSave.GetValueInt()].AddForm(akObject)
    Else
        SSB_TrackingList_Disabled.AddForm(akObject)
    EndIf


    ; Tracking Lists
    If abIsPermanent
        SSB_TrackingList_Permanent.AddForm(akObject)
    Else
        SSB_TrackingList_Temporary.AddForm(akObject)
    EndIf


    If abAutoDetect
        Form akBase = akObject.GetBaseObject()
        If akBase as Static
            SSB_TrackingList_Statics.AddForm(akObject)
        ElseIf akBase as Activator
            SSB_TrackingList_Activators.AddForm(akObject)
        ElseIf akBase as Light
            SSB_TrackingList_Lights.AddForm(akObject)
        EndIf

        return ; Stops the script from entering THE RESTRICTED SECTION.
    EndIf

    If aiType == 1
        SSB_TrackingList_Statics.AddForm(akObject)
    ElseIf aiType == 2
        SSB_TrackingList_Activators.AddForm(akObject)
    ElseIf aiType == 3
        SSB_TrackingList_Lights.AddForm(akObject)
    EndIf

EndFunction


; This is essentially the *definition* of a wrapper function.
Function SwitchSaveMenu()
    FormList oldSave = currentSaveList
    CurrentSaveNum = Switch_Save.Show()

    SSB_CurrentSave.GetSize()
EndFunction


; Removes all ObjectReferences in either a FormList or an Array.
;
; Optionally fades iitems before deletion.
; Pointless call if neither akList nor akForms are present, however no errors will be thrown.
Function DeleteFromListOrArray(Bool abFade, FormList akList = None, Form[] akForms = None)
    If akForms
        Int iMax = akForms.Length
        
        If abFade

            Int i = 0
        
            ; Go through and set everything to fade
            While i < iMax
                (akForms[i] as ObjectReference).DisableNoWait(true)
                i += 1
            EndWhile

            Utility.Wait(2.0) ; Leave time for the fade to finish
            i = 0 ; Reset i for the next loop
        EndIf

        Int i = 0

        ; Go through and delete everything
        While i < iMax
            (akForms[i] as ObjectReference).Delete()
            i += 1
        EndWhile
    EndIf

    if akList
        Int iMax = akList.GetSize()
        
        if abFade

            Int i = 0
        
            ; Go through and set everything to fade
            While i < iMax
                (akList.GetAt(i) as ObjectReference).DisableNoWait(true)
                i += 1
            EndWhile

            Utility.Wait(2.0) ; Leave time for the fade to finish
            i = 0 ; Reset i for the next loop
        EndIf

        Int i = 0

        ; Go through and delete everything
        While i < iMax
            (akList.GetAt(i) as ObjectReference).Delete()
            i += 1
        EndWhile
    EndIf

EndFunction



Function AutoLevel(ObjectReference akObject, Bool doCheck = false) ; Conveiently includes an If as a conveinience function.
    If doCheck && SSB_AutoLevel_Disabled.GetValue() == 1
        debug.Trace("[LVX-SSS] Object Auto-Leveling OFF")
        return
    EndIf

    akObject.SetAngle(0.0, 0.0, Self.GetAngleZ())
    Debug.Trace("[LVX-SSB] Object "+akObject+" auto-leveled")
EndFunction



Function EnterTheMenus(ObjectReference akObject, Bool abUseActivatorMenus)
    if UseSKSE
        EnterSKSEMenus
    else
        EnterNormalMenus
    EndIf
EndFunction

Function EnterSKSEMenus(ObjectReference akObject, Bool abUseActivatorMenus)
EndFunction

Function EnterNormalMenus(ObjectReference akObject, Bool abUseActivatorMenus)
EndFunction




;/$\      $$\           $$\                 $$\      $$\
 $$$\    $$$ |          \__|                $$$\    $$$ |
 $$$$\  $$$$ | $$$$$$\  $$\ $$$$$$$\        $$$$\  $$$$ | $$$$$$\  $$$$$$$\  $$\   $$\
 $$\$$\$$ $$ | \____$$\ $$ |$$  __$$\       $$\$$\$$ $$ |$$  __$$\ $$  __$$\ $$ |  $$ |
 $$ \$$$  $$ | $$$$$$$ |$$ |$$ |  $$ |      $$ \$$$  $$ |$$$$$$$$ |$$ |  $$ |$$ |  $$ |
 $$ |\$  /$$ |$$  __$$ |$$ |$$ |  $$ |      $$ |\$  /$$ |$$   ____|$$ |  $$ |$$ |  $$ |
 $$ | \_/ $$ |\$$$$$$$ |$$ |$$ |  $$ |      $$ | \_/ $$ |\$$$$$$$\ $$ |  $$ |\$$$$$$  |
 \__|     \__| \_______|\__|\__|  \__|      \__|     \__| \_______|\__|  \__| \______/;


; BELL: There's no need to define aiButton as a Function parameter.
;       Instead, I defined it as a variable.
Function Menu(ObjectReference akObject)
    ;Debug.Notification("Legacy Positioner UI Active")    Debug.Trace("[LVX-SSS] Legacy Positioner UI Active")

    Int aiButton = MenuUi.show()

    If     aiButton == 1
        Z_Menu(akObject)
    ElseIf aiButton == 2
        Y_Menu(akObject)
    ElseIf aiButton == 3
        X_Menu(akObject)

    ElseIf aiButton == 4
        Rotate_Menu(akObject)
        ;Debug.Notification("Object is facing "+ GetAngleZ()+" Degrees")        Debug.Trace("[LVX-SSS] Object is facing "+ GetAngleZ()
        Utility.wait(0.1)

    ElseIf aiButton == 5
        Auto_Level_Button(akObject)
        Debug.MessageBox("Level Button")

    ElseIf aiButton == 6
        Self.Disable(True)
        PlayerREF.addItem(MiscObj)
        Delete()

    ElseIf aiButton == 7   ; Options
        MenuUi_Options(akObject)

    ElseIf aiButton == 8
        MenuUi_MakeStatic(akObject)

    EndIf
EndFunction


;/$$$$$$\              $$\                       $$\                                      $$\
 $$  __$$\             $$ |                      $$ |                                     $$ |
 $$ /  $$ |$$\   $$\ $$$$$$\    $$$$$$\          $$ |       $$$$$$\  $$\    $$\  $$$$$$\  $$ |
 $$$$$$$$ |$$ |  $$ |\_$$  _|  $$  __$$\ $$$$$$\ $$ |      $$  __$$\ \$$\  $$  |$$  __$$\ $$ |
 $$  __$$ |$$ |  $$ |  $$ |    $$ /  $$ |\______|$$ |      $$$$$$$$ | \$$\$$  / $$$$$$$$ |$$ |
 $$ |  $$ |$$ |  $$ |  $$ |$$\ $$ |  $$ |        $$ |      $$   ____|  \$$$  /  $$   ____|$$ |
 $$ |  $$ |\$$$$$$  |  \$$$$  |\$$$$$$  |        $$$$$$$$\ \$$$$$$$\    \$  /   \$$$$$$$\ $$ |
 \__|  \__| \______/    \____/  \______/         \________| \_______|    \_/     \_______|\__|



$$$$$$$\              $$\       $$\
$$  __$$\             $$ |      $$ |
$$ |  $$ |$$\   $$\ $$$$$$\   $$$$$$\    $$$$$$\  $$$$$$$\
$$$$$$$\ |$$ |  $$ |\_$$  _|  \_$$  _|  $$  __$$\ $$  __$$\
$$  __$$\ $$ |  $$ |  $$ |      $$ |    $$ /  $$ |$$ |  $$ |
$$ |  $$ |$$ |  $$ |  $$ |$$\   $$ |$$\ $$ |  $$ |$$ |  $$ |
$$$$$$$  |\$$$$$$  |  \$$$$  |  \$$$$  |\$$$$$$  |$$ |  $$ |
\_______/  \______/    \____/    \____/  \______/ \__|  \_/;


Message Property SSB_Notification_AlreadyLevel  Auto

Function Auto_Level_Button(ObjectReference akObject)
    If akObject.GetAngleX() == 0 && akObject.GetAngleY() == 0

    Self.SetAngle(0.0, 0.0, Self.GetAngleZ())
EndFunction




;/$$$$$$\         $$\      $$\
 \____$$ |        $$$\    $$$ |
    $$  /         $$$$\  $$$$ | $$$$$$\  $$$$$$$\  $$\   $$\
   $$  /  $$$$$$\ $$\$$\$$ $$ |$$  __$$\ $$  __$$\ $$ |  $$ |
  $$  /   \______|$$ \$$$  $$ |$$$$$$$$ |$$ |  $$ |$$ |  $$ |
 $$  /            $$ |\$  /$$ |$$   ____|$$ |  $$ |$$ |  $$ |
$$$$$$$$\         $$ | \_/ $$ |\$$$$$$$\ $$ |  $$ |\$$$$$$  |
\________|        \__|     \__| \_______|\__|  \__| \______/;


Function Z_Menu(ObjectReference akObject)
    Int aiButton

    While aiButton ; BELL: Using an Int as a condition checks If it isn't 0
        aiButton =  Z_Ui.show()

        If aiButton == 0 ; Exit Button
            Menu(akObject)
            return
        EndIf

        akObject.DisableNoWait()
        If aiButton == 1
            akObject.SetPosition(X, Y, Z - 50)
        ElseIf aiButton == 2
            akObject.SetPosition(X, Y, Z - 30)
        ElseIf aiButton == 3
            akObject.SetPosition(X, Y, Z - 10)
        ElseIf aiButton == 4
            akObject.SetPosition(X, Y, Z - 1)
        ElseIf aiButton == 5
            akObject.SetPosition(X, Y, Z + 1)
        ElseIf aiButton == 6
            akObject.SetPosition(X, Y, Z + 10)
        ElseIf aiButton == 7
            akObject.SetPosition(X, Y, Z + 30)
        ElseIf aiButton == 8
            akObject.SetPosition(X, Y, Z + 50)
        EndIf
        akObject.EnableNoWait()

    EndWhile
EndFunction


;/\     /$\         $$\      $$\
\$$\   /$  |        $$$\    $$$ |
 \$$\_/$  /         $$$$\  $$$$ | $$$$$$\  $$$$$$$\  $$\   $$\
  \$$$$  /  $$$$$$\ $$\$$\$$ $$ |$$  __$$\ $$  __$$\ $$ |  $$ |
   \$$  /   \______|$$ \$$$  $$ |$$$$$$$$ |$$ |  $$ |$$ |  $$ |
    $$ |            $$ |\$  /$$ |$$   ____|$$ |  $$ |$$ |  $$ |
    $$ |            $$ | \_/ $$ |\$$$$$$$\ $$ |  $$ |\$$$$$$  |
    \__|            \__|     \__| \_______|\__|  \__| \______/;


Function Y_Menu()
    Int aiButton

    While aiButton ; BELL: Using an Int as a condition checks If it isn't 0
        aiButton =  Y_Ui.show()

        If aiButton == 0 ; Exit Button
            Menu()
            return
        EndIf

        Self.DisableNoWait()
        If aiButton == 1
            SetPosition(X, Y - 50, Z)
        ElseIf aiButton == 2
            SetPosition(X, Y - 30, Z)
        ElseIf aiButton == 3
            SetPosition(X, Y - 10, Z)
        ElseIf aiButton == 4
            SetPosition(X, Y - 1, Z)
        ElseIf aiButton == 5
            SetPosition(X, Y + 1, Z)
        ElseIf aiButton == 6
            SetPosition(X, Y + 10, Z)
        ElseIf aiButton == 7
            SetPosition(X, Y + 30, Z)
        ElseIf aiButton == 8
            SetPosition(X, Y + 50, Z)
        EndIf
        Self.EnableNoWait()

    EndWhile
EndFunction

;/\   /-\         $$\      $$\
$$ |  $$ |        $$$\    $$$ |
\$$\ $$  |        $$$$\  $$$$ | $$$$$$\  $$$$$$$\  $$\   $$\
 \$$$$  / $$$$$$\ $$\$$\$$ $$ |$$  __$$\ $$  __$$\ $$ |  $$ |
 $$  $$<  \______|$$ \$$$  $$ |$$$$$$$$ |$$ |  $$ |$$ |  $$ |
$$  /\$$\         $$ |\$  /$$ |$$   ____|$$ |  $$ |$$ |  $$ |
$$ /  $$ |        $$ | \_/ $$ |\$$$$$$$\ $$ |  $$ |\$$$$$$  |
\__|  \__|        \__|     \__| \_______|\__|  \__| \______/;


Function X_Menu()
    Int aiButton

    While aiButton ; BELL: Using an Int as a condition checks If it isn't 0
        aiButton =  X_Ui.show()

        If aiButton == 0 ; Exit Button
            Menu()
            return
        EndIf

        If aiButton == 1
            SetPosition(X - 50, Y, Z)
        ElseIf aiButton == 2
            SetPosition(X - 30, Y, Z)
        ElseIf aiButton == 3
            SetPosition(X - 10, Y, Z)
        ElseIf aiButton == 4
            SetPosition(X - 1, Y, Z)
        ElseIf aiButton == 5
            SetPosition(X + 1, Y, Z)
        ElseIf aiButton == 6
            SetPosition(X + 10, Y, Z)
        ElseIf aiButton == 7
            SetPosition(X + 30, Y, Z)
        ElseIf aiButton == 8
            SetPosition(X + 50, Y, Z)
        EndIf
        Self.EnableNoWait()

    EndWhile
EndFunction

;/$$$$$$\              $$\                 $$\                     $$\      $$\
 $$  __$$\             $$ |                $$ |                    $$$\    $$$ |
 $$ |  $$ | $$$$$$\  $$$$$$\    $$$$$$\  $$$$$$\    $$$$$$\        $$$$\  $$$$ | $$$$$$\  $$$$$$$\  $$\   $$\
 $$$$$$$  |$$  __$$\ \_$$  _|   \____$$\ \_$$  _|  $$  __$$\       $$\$$\$$ $$ |$$  __$$\ $$  __$$\ $$ |  $$ |
 $$  __$$< $$ /  $$ |  $$ |     $$$$$$$ |  $$ |    $$$$$$$$ |      $$ \$$$  $$ |$$$$$$$$ |$$ |  $$ |$$ |  $$ |
 $$ |  $$ |$$ |  $$ |  $$ |$$\ $$  __$$ |  $$ |$$\ $$   ____|      $$ |\$  /$$ |$$   ____|$$ |  $$ |$$ |  $$ |
 $$ |  $$ |\$$$$$$  |  \$$$$  |\$$$$$$$ |  \$$$$  |\$$$$$$$\       $$ | \_/ $$ |\$$$$$$$\ $$ |  $$ |\$$$$$$  |
 \__|  \__| \______/    \____/  \_______|   \____/  \_______|      \__|     \__| \_______|\__|  \__| \______/;


Function Rotate_Menu()
    While abMenu
        Int aiButton =  Rotate_Ui.show()
        If aiButton == 0 ; Exit Button
            Menu()
            return
        EndIf

        Self.DisableNoWait()
        If aiButton == 1
            Self.SetAngle(0.0, 0.0, self.GetAngleZ() - 50.0)
        ElseIf aiButton == 2
            Self.SetAngle(0.0, 0.0, self.GetAngleZ() - 30.0)
        ElseIf aiButton == 3
            Self.SetAngle(0.0, 0.0, self.GetAngleZ() - 10.0)
        ElseIf aiButton == 4
            Self.SetAngle(0.0, 0.0, self.GetAngleZ() - 1.0)
        ElseIf aiButton == 5
            Self.SetAngle(0.0, 0.0, self.GetAngleZ() + 1.0)
        ElseIf aiButton == 6
            Self.SetAngle(0.0, 0.0, self.GetAngleZ() + 10.0)
        ElseIf aiButton == 7
            Self.SetAngle(0.0, 0.0, self.GetAngleZ() + 30.0)
        ElseIf aiButton == 8
            Self.SetAngle(0.0, 0.0, self.GetAngleZ() + 50.0)
        EndIf

        Self.EnableNoWait()
    EndWhile
EndFunction

;/$$$$$$\              $$\     $$\
 $$  __$$\             $$ |    \__|
 $$ /  $$ | $$$$$$\  $$$$$$\   $$\  $$$$$$\  $$$$$$$\   $$$$$$$\
 $$ |  $$ |$$  __$$\ \_$$  _|  $$ |$$  __$$\ $$  __$$\ $$  _____|
 $$ |  $$ |$$ /  $$ |  $$ |    $$ |$$ /  $$ |$$ |  $$ |\$$$$$$\
 $$ |  $$ |$$ |  $$ |  $$ |$$\ $$ |$$ |  $$ |$$ |  $$ | \____$$\
  $$$$$$  |$$$$$$$  |  \$$$$  |$$ |\$$$$$$  |$$ |  $$ |$$$$$$$  |
  \______/ $$  ____/    \____/ \__| \______/ \__|  \__|\_______/
           $$ |
           $$ |
           \__/;

Function MenuUi_Options()
    Int aiButton =  MenuUi_Options.show()

    If aiButton == 0
        Menu()
    ElseIf aiButton == 1
        MenuUi_Options_PositionerMenu()
    EndIf
EndFunction

;BELL: Assuming the menu's only options are 0 and 1, you can use a much more elegant system, like this one.
;/
Function MenuUi_Options()

    Int aiButton =  MenuUi_Options.show()

    If aiButton == 1
        MenuUi_Options_PositionerMenu()
        Return
    Else
        Menu()
    EndIf
EndFunction
/;


Function MenuUi_Options_PositionerMenu() ; Show Option Menu
    Int aiButton= MenuUi_Options_PositionerMenu.Show()

    If aibutton == 0
        MenuUi_Options()

    ElseIf aiButton== 1
        SSB_SKSE_Positioner_Toggle.cast(PlayerRef)

    ElseIf aiButton == 2
        SSB_Auto_Level_Object_Global_Toggle_Spell.Cast(PlayerRef)

    ; BELL: No use wasing the processing power to evaluate that ElseIF. If it does nothing, you can make it a comment instead.
    ; ElseIf aiButton == 3, do nothing

    EndIf

EndFunction


;/$$$$$\    $$\                 $$\     $$\                 $$\      $$\
$$  __$$\   $$ |                $$ |    \__|                $$$\    $$$ |
$$ /  \__|$$$$$$\    $$$$$$\  $$$$$$\   $$\  $$$$$$$\       $$$$\  $$$$ | $$$$$$\  $$$$$$$\  $$\   $$\
\$$$$$$\  \_$$  _|   \____$$\ \_$$  _|  $$ |$$  _____|      $$\$$\$$ $$ |$$  __$$\ $$  __$$\ $$ |  $$ |
 \____$$\   $$ |     $$$$$$$ |  $$ |    $$ |$$ /            $$ \$$$  $$ |$$$$$$$$ |$$ |  $$ |$$ |  $$ |
$$\   $$ |  $$ |$$\ $$  __$$ |  $$ |$$\ $$ |$$ |            $$ |\$  /$$ |$$   ____|$$ |  $$ |$$ |  $$ |
\$$$$$$  |  \$$$$  |\$$$$$$$ |  \$$$$  |$$ |\$$$$$$$\       $$ | \_/ $$ |\$$$$$$$\ $$ |  $$ |\$$$$$$  |
 \______/    \____/  \_______|   \____/ \__| \_______|      \__|     \__| \_______|\__|  \__| \______/;

; BELL: I removed the SKSE variant since no SKSE-exclusive functions exist in the SKSE version.

Function MenuUi_MakeStatic()
    Int aiButton = MenuUi_MakeStatic.show()

    ; BELL: Early Returns make code easier to parse
    If aiButton != 1
        return
    EndIf

    ;BELL: DisableNoWait() and Disable() have the same Function, only the "NoWait" one doesn't wait for the disable to finish.
    ;      There are quite a few of these in Papyrus.

    ; Start fading to give the illusion
    Self.DisableNoWait(True)

    SSB_A_DeleteAll.AddForm(PlaceAtMe(StaticDummy)) ; Creates a StaticDummy and adds that to the Delete All list.
    ;/ Human-readable:
        ObjectReference newStatic = PlaceAtMe(StaticDummy)
        SSB_A_DeleteAll.AddForm(newStatic)
    /;

    ;BELL: Fading takes a While, so we should wait for it to finish before deleting outselves
    ;      While technically takes slightly longer, it is near-impossible to replicate that delay otherwise
    ;      because it is rather dependant on framerate, which can vary greatly from setup-to-setup and even cell-to-cell
    ;      Therefore, duplicating the Function call and waiting for it to finish is the ideal solution
    Self.Disable(True)
    Sent.Delete()

EndFunction

;/$$$$$\  $$\   $$\  $$$$$$\  $$$$$$$$\       $$\      $$\           $$\
$$  __$$\ $$ | $$  |$$  __$$\ $$  _____|      $$$\    $$$ |          \__|
$$ /  \__|$$ |$$  / $$ /  \__|$$ |            $$$$\  $$$$ | $$$$$$\  $$\ $$$$$$$\
\$$$$$$\  $$$$$  /  \$$$$$$\  $$$$$\          $$\$$\$$ $$ | \____$$\ $$ |$$  __$$\
 \____$$\ $$  $$<    \____$$\ $$  __|         $$ \$$$  $$ | $$$$$$$ |$$ |$$ |  $$ |
$$\   $$ |$$ |\$$\  $$\   $$ |$$ |            $$ |\$  /$$ |$$  __$$ |$$ |$$ |  $$ |
\$$$$$$  |$$ | \$$\ \$$$$$$  |$$$$$$$$\       $$ | \_/ $$ |\$$$$$$$ |$$ |$$ |  $$ |
 \______/ \__|  \__| \______/ \________|      \__|     \__| \_______|\__|\__|  \__/;



Function MenuUi_SKSE()
   Int aiButton =  MenuUi_SKSE.show()


    ;Debug.Notification("SKSE Positioner Active")    Debug.Trace("[LVX-SSS] SKSE Positioner Active")

    ;/    Move  Z   /; If aiButton == 1
        Z_Menu_SKSE()
    ;/    Move  Y   /; ElseIf aiButton == 2
        Y_Menu_SKSE()
    ;/    Move  X   /; ElseIf aiButton == 3
        X_Menu_SKSE()

    ;/    Rotate    /; ElseIf aiButton == 4
        Rotate_Menu_SKSE()
        ;Debug.Notification("Object is facing "+ GetAngleZ()+" Degrees")        Debug.Trace("[LVX-SSS] Object is facing "+ GetAngleZ()
        ;BELL: What purpose does the "Utility.wait(0.1)" that was here serve?

    ;/  Auto-Level  /; ElseIf aiButton == 5
        Auto_Level_Button()

    ;/    Pick Up   /; ElseIf aiButton == 6
       Self.DisableNoWait(True)
       PlayerREF.AddItem(MiscObj)

       ;BELL: I changed it to a "sandwhiched" disablement system,
       ;      where the item starts fading and, While it is fading, the item is added to the Player. Just a player conveinience.
       Self.Disable(True)
       Self.Delete()

    ;/    Options   /; ElseIf aiButton == 7
      MenuUi_Options_SKSE()

    ;/  Make Static /; ElseIf aiButton == 8
        MenuUi_MakeStatic()

    EndIf
EndFunction

;/$$$$$$$\        $$\      $$\                                      $$$$$$\  $$\   $$\  $$$$$$\  $$$$$$$$\
 \____$$  |       $$$\    $$$ |                                    $$  __$$\ $$ | $$  |$$  __$$\ $$  _____|
    $$  /         $$$$\  $$$$ | $$$$$$\  $$$$$$$\  $$\   $$\       $$ /  \__|$$ |$$  / $$ /  \__|$$ |
   $$  /  $$$$$$\ $$\$$\$$ $$ |$$  __$$\ $$  __$$\ $$ |  $$ |      \$$$$$$\  $$$$$  /  \$$$$$$\  $$$$$\
  $$  /   \______|$$ \$$$  $$ |$$$$$$$$ |$$ |  $$ |$$ |  $$ |       \____$$\ $$  $$<    \____$$\ $$  __|
 $$  /            $$ |\$  /$$ |$$   ____|$$ |  $$ |$$ |  $$ |      $$\   $$ |$$ |\$$\  $$\   $$ |$$ |
$$$$$$$$\         $$ | \_/ $$ |\$$$$$$$\ $$ |  $$ |\$$$$$$  |      \$$$$$$  |$$ | \$$\ \$$$$$$  |$$$$$$$$\
\________|        \__|     \__| \_______|\__|  \__| \______/        \______/ \__|  \__| \______/ \_______/;


;BELL: I know someone else made these for you but I still must compliment the formatting!
;      The only problem is the lack of While loops, so I optimized that.
;
;      Also, mine keeps the positioner until we're done. Quality of life.
;
;      These changes are copy-pasta'd over the position menu fmily.

Function Z_Menu_SKSE()
   Int aiButton =  Z_Ui_SKSE.show()

    Utility.Wait(0.1)
    Self.DisableNoWait()

    ; Make the positioner object
    ObjectReference PositionObject = Self.PlaceAtMe(StaticDummy, 1)
    PositionObject.SetMotionType(4)

    While aiButton ; Casting an Int to a Bool (e.g. using an Int as your condition) checks If it is non-zeo.


        If aiButton == 1
            Int ActivateKey = Input.GetMappedKey("Activate")
            While Input.IsKeyPressed(ActivateKey) || Input.IsKeyPressed(256) ;moves object down until the activate key or left mouse button is released.

                PositionObject.TranslateTo(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ() - 5, PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ(), 500, 0)
            EndWhile
        ElseIf aiButton == 2
            Int ActivateKey = Input.GetMappedKey("Activate")
            While Input.IsKeyPressed(ActivateKey) || Input.IsKeyPressed(256) ;moves object up until the activate key or left mouse button is released.

                PositionObject.TranslateTo(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ() + 5, PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ(), 500, 0)
            EndWhile
        EndIf

        Utility.Wait(0.1)
        aiButton =  Z_Ui_SKSE.show() ; The loop checks for it
    EndWhile


    ; Moves this object to the positioner
    Self.SetPosition(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ())
    Self.EnableNoWait()

    ; ...and executes "you've outlived your usefulness" on the positioner object.
    PositionObject.Disable()
    PositionObject.Delete()

    ; Return to the main menu
    MenuUi_SKSE()

EndFunction


;/\     /$\         $$\      $$\                                      $$$$$$\  $$\   $$\  $$$$$$\  $$$$$$$$\
\$$\   /$  |        $$$\    $$$ |                                    $$  __$$\ $$ | $$  |$$  __$$\ $$  _____|
 \$$\_/$  /         $$$$\  $$$$ | $$$$$$\  $$$$$$$\  $$\   $$\       $$ /  \__|$$ |$$  / $$ /  \__|$$ |
  \$$$$  /  $$$$$$\ $$\$$\$$ $$ |$$  __$$\ $$  __$$\ $$ |  $$ |      \$$$$$$\  $$$$$  /  \$$$$$$\  $$$$$\
   \$$  /   \______|$$ \$$$  $$ |$$$$$$$$ |$$ |  $$ |$$ |  $$ |       \____$$\ $$  $$<    \____$$\ $$  __|
    $$ |            $$ |\$  /$$ |$$   ____|$$ |  $$ |$$ |  $$ |      $$\   $$ |$$ |\$$\  $$\   $$ |$$ |
    $$ |            $$ | \_/ $$ |\$$$$$$$\ $$ |  $$ |\$$$$$$  |      \$$$$$$  |$$ | \$$\ \$$$$$$  |$$$$$$$$\
    \__|            \__|     \__| \_______|\__|  \__| \______/        \______/ \__|  \__| \______/ \_______/;


Function Y_Menu_SKSE()
   Int aiButton =  Y_Ui_SKSE.show()

    Utility.Wait(0.1)
    Self.DisableNoWait()

    ; Make the positioner object
    ObjectReference PositionObject = Self.PlaceAtMe(StaticDummy, 1)
    PositionObject.SetMotionType(4)

    While aiButton ; Casting an Int to a Bool (e.g. using an Int as your condition) checks If it is non-zeo.


        If aiButton == 1
            Int ActivateKey = Input.GetMappedKey("Activate")
            While Input.IsKeyPressed(ActivateKey) || Input.IsKeyPressed(256) ;moves object down until the activate key or left mouse button is released.

                PositionObject.TranslateTo(PositionObject.GetPositionX(), PositionObject.GetPositionY() - 5, PositionObject.GetPositionZ(), PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ(), 500, 0)
            EndWhile
        ElseIf aiButton == 2
            Int ActivateKey = Input.GetMappedKey("Activate")
            While Input.IsKeyPressed(ActivateKey) || Input.IsKeyPressed(256) ;moves object up until the activate key or left mouse button is released.

                PositionObject.TranslateTo(PositionObject.GetPositionX(), PositionObject.GetPositionY() + 5, PositionObject.GetPositionZ(), PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ(), 500, 0)
            EndWhile
        EndIf

        Utility.Wait(0.1)
        aiButton =  Y_Ui_SKSE.show() ; The loop checks for it
    EndWhile


    ; Moves this object to the positioner
    Self.SetPosition(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ())
    Self.EnableNoWait()

    ; ...and executes "you've outlived your usefulness" on the positioner object.
    PositionObject.Disable()
    PositionObject.Delete()

    ; Return to the main menu
    MenuUi_SKSE()

EndFunction


;/$\   /$\         $$\      $$\                                      $$$$$$\  $$\   $$\  $$$$$$\  $$$$$$$$\
  $$|  |$|         $$$\    $$$ |                                    $$  __$$\ $$ | $$  |$$  __$$\ $$  _____|
  \$\_/$ |         $$$$\  $$$$ | $$$$$$\  $$$$$$$\  $$\   $$\       $$ /  \__|$$ |$$  / $$ /  \__|$$ |
   \$$$  / $$$$$$\ $$\$$\$$ $$ |$$  __$$\ $$  __$$\ $$ |  $$ |      \$$$$$$\  $$$$$  /  \$$$$$$\  $$$$$\
  $$  $$<  \______|$$ \$$$  $$ |$$$$$$$$ |$$ |  $$ |$$ |  $$ |       \____$$\ $$  $$<    \____$$\ $$  __|
 $$  /\$$\         $$ |\$  /$$ |$$   ____|$$ |  $$ |$$ |  $$ |      $$\   $$ |$$ |\$$\  $$\   $$ |$$ |
 $ /   $$ |        $$ | \_/ $$ |\$$$$$$$\ $$ |  $$ |\$$$$$$  |      \$$$$$$  |$$ | \$$\ \$$$$$$  |$$$$$$$$\
|_|    \__|        \__|     \__| \_______|\__|  \__| \______/        \______/ \__|  \__| \______/ \_______/;


FunctionX_Menu_SKSE()
   Int aiButton =  X_Ui_SKSE.show()

    Utility.Wait(0.1)
    Self.DisableNoWait()

    ; Make the positioner object
    ObjectReference PositionObject = Self.PlaceAtMe(StaticDummy, 1)
    PositionObject.SetMotionType(4)

    While aiButton ; Casting an Int to a Bool (e.g. using an Int as your condition) checks If it is non-zeo.


        If aiButton == 1
            Int ActivateKey = Input.GetMappedKey("Activate")
            While Input.IsKeyPressed(ActivateKey) || Input.IsKeyPressed(256) ;moves object down until the activate key or left mouse button is released.

                PositionObject.TranslateTo(PositionObject.GetPositionX() - 5, PositionObject.GetPositionY(), PositionObject.GetPositionZ(), PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ(), 500, 0)
            EndWhile
        ElseIf aiButton == 2
            Int ActivateKey = Input.GetMappedKey("Activate")
            While Input.IsKeyPressed(ActivateKey) || Input.IsKeyPressed(256) ;moves object up until the activate key or left mouse button is released.

                PositionObject.TranslateTo(PositionObject.GetPositionX() + 5, PositionObject.GetPositionY(), PositionObject.GetPositionZ(), PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ(), 500, 0)
            EndWhile
        EndIf

        Utility.Wait(0.1)
        aiButton =  X_Ui_SKSE.show() ; The loop checks for it
    EndWhile


    ; Moves this object to the positioner
    Self.SetPosition(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ())
    Self.EnableNoWait()

    ; ...and executes "you've outlived your usefulness" on the positioner object.
    PositionObject.Disable()
    PositionObject.Delete()

    ; Return to the main menu
    MenuUi_SKSE()

EndFunction

;/$$$$$\              $$\                 $$\                      $$$$$$\  $$\   $$\  $$$$$$\  $$$$$$$$\
|$  __$$\             $$ |                $$ |                    $$  __$$\ $$ | $$  |$$  __$$\ $$  _____|
|$ |  $$ | $$$$$$\  $$$$$$\    $$$$$$\  $$$$$$\    $$$$$$\        $$ /  \__|$$ |$$  / $$ /  \__|$$ |
/$$$$$$  /$$  __$$\ \_$$  _|   \____$$\ \_$$  _|  $$  __$$\       \$$$$$$\  $$$$$  /  \$$$$$$\  $$$$$\
|$  __$$< $$ /  $$ |  $$ |     $$$$$$$ |  $$ |    $$$$$$$$ |       \____$$\ $$  $$<    \____$$\ $$  __|
|$ |  $$ |$$ |  $$ |  $$ |$$\ $$  __$$ |  $$ |$$\ $$   ____|      $$\   $$ |$$ |\$$\  $$\   $$ |$$ |
|$ |  $$ |\$$$$$$  |  \$$$$  |\$$$$$$$ |  \$$$$  |\$$$$$$$\       \$$$$$$  |$$ | \$$\ \$$$$$$  |$$$$$$$$\
\__|  \__| \______/    \____/  \_______|   \____/  \_______|       \______/ \__|  \__| \______/ \_______/;


Function Rotate_Menu_SKSE()
   Int aiButton =  Rotate_Ui_SKSE.show()

    Utility.Wait(0.1)
    Self.DisableNoWait()

    ; Make the positioner object
    ObjectReference PositionObject = Self.PlaceAtMe(StaticDummy, 1)
    PositionObject.SetMotionType(4)

    While aiButton ; Casting an Int to a Bool (e.g. using an Int as your condition) checks If it is non-zeo.


        If aiButton == 1
            Int ActivateKey = Input.GetMappedKey("Activate")
            While Input.IsKeyPressed(ActivateKey) || Input.IsKeyPressed(256) ;moves object down until the activate key or left mouse button is released.

                PositionObject.TranslateTo(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ(), PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ() - 5, 500, 0)
            EndWhile
        ElseIf aiButton == 2
            Int ActivateKey = Input.GetMappedKey("Activate")
            While Input.IsKeyPressed(ActivateKey) || Input.IsKeyPressed(256) ;moves object up until the activate key or left mouse button is released.

                PositionObject.TranslateTo(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ(), PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ() + 5, 500, 0)
            EndWhile
        EndIf

        Utility.Wait(0.1)
        aiButton =  Rotate_Ui_SKSE.show() ; The loop checks for it
    EndWhile

    ; Moves this object to the positioner
    Self.SetAngle(PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ())
    Self.EnableNoWait()

    ; ...and executes "you've outlived your usefulness" on the positioner object.
    PositionObject.Disable()
    PositionObject.Delete()

    ; Return to the main menu
    MenuUi_SKSE()

EndFunction


;/$$$$$$\              $$\     $$\                                      $$$$$$\  $$\   $$\  $$$$$$\  $$$$$$$$\
 $$  __$$\             $$ |    \__|                                    $$  __$$\ $$ | $$  |$$  __$$\ $$  _____|
 $$ /  $$ | $$$$$$\  $$$$$$\   $$\  $$$$$$\  $$$$$$$\   $$$$$$$\       $$ /  \__|$$ |$$  / $$ /  \__|$$ |
 $$ |  $$ |$$  __$$\ \_$$  _|  $$ |$$  __$$\ $$  __$$\ $$  _____|      \$$$$$$\  $$$$$  /  \$$$$$$\  $$$$$\
 $$ |  $$ |$$ /  $$ |  $$ |    $$ |$$ /  $$ |$$ |  $$ |\$$$$$$\         \____$$\ $$  $$<    \____$$\ $$  __|
 $$ |  $$ |$$ |  $$ |  $$ |$$\ $$ |$$ |  $$ |$$ |  $$ | \____$$\       $$\   $$ |$$ |\$$\  $$\   $$ |$$ |
  $$$$$$  |$$$$$$$  |  \$$$$  |$$ |\$$$$$$  |$$ |  $$ |$$$$$$$  |      \$$$$$$  |$$ | \$$\ \$$$$$$  |$$$$$$$$\
  \______/ $$  ____/    \____/ \__| \______/ \__|  \__|\_______/        \______/ \__|  \__| \______/ \_______/
           $$ |
           $$ |
           \__|


Function MenuUi_Options_SKSE()

        Int aiButton =  MenuUi_Options_SKSE.show()
        
        ;/         Back        /; If aiButton == 0
            MenuUi_SKSE()

        ;/ Positioning Options /; ElseIf aiButton==1
            MenuUi_Options_PositionerMenu()

        ;/  Toggle Auto-Level  /;ElseIf aiButton == 2
            SSB_Auto_Level_Object_Global_Toggle_Spell.cast(PlayerRef)

        ;/      Delete All     /; ElseIf aiButton == 3

            ;BELL: You should make this into a message (yes, they can be notifications too).
            ;      It's easier for translators and prevents you from having to edit the script should you ever want to change it.

            ; Use_Lesser_Power_Msg.Show()
            Debug.Notification("Use the Skyrim Settelement Builder Options: Lesser Power To Delete All")            Debug.Trace("[LVX-SSS] Use the Skyrim Settelement Builder Options: Lesser Power To Delete All")

        EndIf
EndFunction


Function MenuUi_Options_PositionerMenu_SKSE() ; Show Option Menu
    Int aiButton= MenuUi_Options_PositionerMenu_SKSE.Show()

    ;BELL: You can use the commented-out code when you add more options. Or, you can expand this. Either way works.
    If aibutton == 1
        SSB_SKSE_Positioner_Toggle.cast(PlayerRef)
    Else
        MenuUi_Options_SKSE()
    EndIf


    ;/
    If aibutton == 0
        MenuUi_Options_SKSE()

    ElseIf aiButton == 1
        SSB_SKSE_Positioner_Toggle.cast(PlayerRef)
    EndIf
    /;
EndFunction