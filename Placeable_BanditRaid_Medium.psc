Scriptname Placeable_BanditRaid_Medium extends ObjectReference  


import game
import debug
Message Property BattleStartMessage  Auto
Message Property  Placeable_AA_RaidMenu  Auto
Int Property iResetRound = 1 Auto
MiscObject property MiscObj  Auto


ActorBase property myCreature1  Auto  ;Archers
ActorBase property myCreature2  Auto  ;Melee Fighters
ActorBase property myCreature3  Auto  ;Mages
ActorBase property myCreature4  Auto  ;Tank;
ActorBase property myCreature5  Auto  ;Tank;
ActorBase property myCreature6  Auto  ;Boss1
ActorBase property myCreature7  Auto  ;Boss2
ActorBase property myCreature8  Auto  ;Boss3
;ActorBase property myCreature9  Auto
;ActorBase property myCreature10  Auto
;ActorBase property myCreature11  Auto
;ActorBase property myCreature12  Auto
;ActorBase property myCreature13  Auto
;ActorBase property myCreature14  Auto
;ActorBase property myCreature15  Auto
;ActorBase property myCreature16  Auto
;ActorBase property myCreature17  Auto
;ActorBase property myCreature18  Auto
;ActorBase property myCreature19  Auto
;ActorBase property myCreature20  Auto
;ActorBase property myCreature21  Auto
;ActorBase property myCreature22  Auto
;ActorBase property myCreature23  Auto
;ActorBase property myCreature24  Auto
;ActorBase property myCreature25  Auto
;ActorBase property myCreature26  Auto
;ActorBase property myCreature27  Auto
;ActorBase property myCreature28  Auto
;ActorBase property myCreature29  Auto
;ActorBase property myCreature30  Auto




;Spawn Timer
Event OnInit()
    RegisterForSingleUpdateGameTime(iResetRound)
   Utility.wait(5)
   BattleStartMessage.show()

EndEvent

Event OnUpdateGameTime()
    debug.Notification("Brace yourself ")
    Debug.Trace("[LVX-SSS] Brace yourself ")
    Utility.Wait(2)
    debug.Messagebox("THE BANDITS HAVE ARRIVED")                ;ARCHERS
    Utility.Wait(2)


;____________________________________________________________   
;  ARCHERS Wave 1
;------------------------------------------------------------------------------------------

    Self.PlaceActorAtMe(myCreature1)
    Self.PlaceActorAtMe(myCreature1)
    Self.PlaceActorAtMe(myCreature1)
    Self.PlaceActorAtMe(myCreature1)
   
   Utility.Wait(15)
;____________________________________________________________   
; MELEE FIGHTERS Wave 1
;------------------------------------------------------------------------------------------

    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature4).StartCombat(game.getplayer()) ;Tank
    


      Utility.Wait(15)
       Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
       Self.PlaceActorAtMe(myCreature5).StartCombat(game.getplayer()) ;Tank
       Self.PlaceActorAtMe(myCreature5).StartCombat(game.getplayer()) ;Tank

     Utility.Wait(15)
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
       Self.PlaceActorAtMe(myCreature6).StartCombat(game.getplayer()) ;Boss 1
        Utility.wait(25)


;____________________________________________________________   
;MAGES Wave 1
;------------------------------------------------------------------------------------------


     Utility.wait(10)
          Self.PlaceActorAtMe(myCreature3).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature7).StartCombat(game.getplayer()) ;Boss 2
    
;____________________________________________________________   
;  ARCHERS & MELEE Wave 2
;------------------------------------------------------------------------------------------


 Utility.wait(20)

    Self.PlaceActorAtMe(myCreature5).StartCombat(game.getplayer()) ;TANK
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature1).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature1).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature1).StartCombat(game.getplayer())

;____________________________________________________________   
; MELEE FIGHTERS Wave 2
;------------------------------------------------------------------------------------------


       Utility.wait(10)
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
        Utility.wait(20)
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())

   Self.PlaceActorAtMe(myCreature1).StartCombat(game.getplayer())
   Self.PlaceActorAtMe(myCreature1).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature1).StartCombat(game.getplayer())
        Self.PlaceActorAtMe(myCreature8).StartCombat(game.getplayer()) ;BOSS
Utility.wait(30)
Debug.Notification("Enemy Reinforcements Have Arrived")
Debug.Trace("[LVX-SSS] Enemy Reinforcements Have Arrived")


   
     Debug.Messagebox("Last Enemy Has Entered The Battle")
 
 Menu()
 
             
EndEvent

Function Menu(Int aiButton = 0)
       aiButton = Placeable_AA_RaidMenu.show()   ;Shows Bandit Raid Menu to continue the Raid or startOver
 If aiButton == 0 
RegisterForSingleUpdateGameTime(iResetRound) ;Event  Init() is at the begging of the script
           Debug.Notification("Round Reset")
           Debug.Trace("[LVX-SSS] Round Reset")
           Utility.Wait(10)
           Debug.Messagebox("You have 1 hours before enemy reinforcements arrive")

     elseIf aiButton == 1  
       self.Disable(True)
       game.getPlayer().addItem(MiscObj)
       DeleteWhenAble()
       Delete()
     

EndIf
EndFunction