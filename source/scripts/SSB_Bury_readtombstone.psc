Scriptname ReadTombStone extends ObjectReference  

String Property actorName  Auto  
String Property DateOfDeath  Auto 
BTDVars Property BTDQuest  Auto 

Event OnInit()
    If (!actorName)
        actorName = BTDQuest.actorName
        DateOfDeath = BTDQuest.DateOfDeath
        TheDeceased = BTDQuest.TheDeceased
    EndIf
EndEvent

Event OnActivate(ObjectReference akActionRef)
    If akActionRef == Game.GetPlayer()
        Int index1 = StringUtil.Find(DateOfDeath, " ")
        string interred = StringUtil.Substring(DateOfDeath, 0, index1) 
        debug.MessageBox("Here lies " + actorName + ".\n\nInterred "+interred)
    EndIf
EndEvent
Actor Property TheDeceased  Auto  
