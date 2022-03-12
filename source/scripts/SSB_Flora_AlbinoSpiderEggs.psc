Scriptname SSB_Flora_AlbinoSpiderEggs extends ObjectReference  


Actorbase Property Enemy  Auto


Event OnActivate(ObjectReference akActionRef)    ;Get Eggs From Albino Nest
  Int eggs = Self.GetItemCount(Game.Getform(0x04017719))

  If (eggs == 0)
    Debug.MessageBox("No more Albino Eggs at this time")
 
 
Else
    

If (eggs == 3) ; Say Nothing Just Recieve Eggs

Int iRoll = Utility.RandomInt(0,15)
If iRoll == 12
Debug.Notification("Oops the eggs hatched!!")
Debug.Trace("[LVX-SSS] Oops the eggs hatched!!")

Game.GetPlayer().PlaceactorAtMe(Enemy).StartCombat(Game.GetPlayer())
Game.GetPlayer().PlaceactorAtMe(Enemy).StartCombat(Game.GetPlayer())
Game.GetPlayer().PlaceactorAtMe(Enemy).StartCombat(Game.GetPlayer())



EndIf
EndIf  
EndIf
EndEvent