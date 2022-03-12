Scriptname SSB_BanditRaid_Large extends ObjectReference  


import game
import debug
Message Property BattleStartMessage  Auto
Message Property  SSB_AA_RaidMenu  Auto
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



;Spawn Timer
Event OnInit()
    RegisterForSingleUpdateGameTime(iResetRound)
   Utility.wait(5)
   BattleStartMessage.show()
   Debug.Messagebox("1 Hour Until Arrival")

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
    Self.PlaceActorAtMe(myCreature1)
    Self.PlaceActorAtMe(myCreature1)

   Utility.Wait(15)
;____________________________________________________________   
; MELEE FIGHTERS Wave 1
;------------------------------------------------------------------------------------------

    
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature4).StartCombat(game.getplayer()) ;Tank
    


    Utility.Wait(15)
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature5).StartCombat(game.getplayer()) ;Tank
     Utility.Wait(15)
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature6).StartCombat(game.getplayer()) ;Boss 1
        Utility.wait(25)


    Self.PlaceActorAtMe(myCreature1)
    Self.PlaceActorAtMe(myCreature1)
    Self.PlaceActorAtMe(myCreature1)

;____________________________________________________________   
;MAGES Wave 1
;------------------------------------------------------------------------------------------


     Utility.wait(10)
     Self.PlaceActorAtMe(myCreature3).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature3).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature3).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature3).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature3).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature7).StartCombat(game.getplayer()) ;Boss 2
    
;____________________________________________________________   
;  ARCHERS & MELEE Wave 2
;------------------------------------------------------------------------------------------


 Utility.wait(20)

    Self.PlaceActorAtMe(myCreature4).StartCombat(game.getplayer()) ;TANK
    Self.PlaceActorAtMe(myCreature1).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature1).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature5).StartCombat(game.getplayer()) ;TANK
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
   
;____________________________________________________________   
; MELEE FIGHTERS Wave 2
;------------------------------------------------------------------------------------------


Utility.wait(10)
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
        Utility.wait(20)

   Self.PlaceActorAtMe(myCreature1).StartCombat(game.getplayer())
   Self.PlaceActorAtMe(myCreature1).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature1).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature6).StartCombat(game.getplayer()) ;BOSS
     Self.PlaceActorAtMe(myCreature7).StartCombat(game.getplayer()) ;BOSS
    Self.PlaceActorAtMe(myCreature8).StartCombat(game.getplayer()) ;BOSS
Utility.wait(30)
Debug.Notification("Enemy Reinforcements Have Arrived")
Debug.Trace("[LVX-SSS] Enemy Reinforcements Have Arrived")

;-----------------------------------------------------------------------------------------------
; ROUND 2
;----------------------------------------------------------------------------------------------

;____________________________________________________________   
;  ARCHERS Wave 1
;------------------------------------------------------------------------------------------

    Self.PlaceActorAtMe(myCreature1)
    Self.PlaceActorAtMe(myCreature1)
    Self.PlaceActorAtMe(myCreature1)
    
    Self.PlaceActorAtMe(myCreature1)
    Self.PlaceActorAtMe(myCreature1)
    Self.PlaceActorAtMe(myCreature1)

   Utility.Wait(10)
;____________________________________________________________   
; MELEE FIGHTERS Wave 1
;------------------------------------------------------------------------------------------

    
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature4).StartCombat(game.getplayer()) ;Tank
    


    Utility.Wait(10)
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature5).StartCombat(game.getplayer()) ;Tank
     Utility.Wait(10)
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature6).StartCombat(game.getplayer()) ;Boss 1
        Utility.wait(25)


;____________________________________________________________   
;MAGES Wave 1
;------------------------------------------------------------------------------------------


     Utility.wait(25)
     Self.PlaceActorAtMe(myCreature3).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature3).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature3).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature3).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature3).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature7).StartCombat(game.getplayer()) ;Boss 2
    
;____________________________________________________________   
;  ARCHERS & MELEE Wave 2
;------------------------------------------------------------------------------------------


 Utility.wait(20)

    Self.PlaceActorAtMe(myCreature4).StartCombat(game.getplayer()) ;TANK
    Self.PlaceActorAtMe(myCreature1).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature1).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature5).StartCombat(game.getplayer()) ;TANK
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
   
;____________________________________________________________   
; MELEE FIGHTERS Wave 2
;------------------------------------------------------------------------------------------
    
    Utility.Wait(20)
    Self.PlaceActorAtMe(myCreature1)
    Self.PlaceActorAtMe(myCreature1)
    Self.PlaceActorAtMe(myCreature1)
    
    Self.PlaceActorAtMe(myCreature1)
    Self.PlaceActorAtMe(myCreature1)
    Self.PlaceActorAtMe(myCreature1)


Utility.wait(10)
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature3).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature3).StartCombat(game.getplayer())
        Utility.wait(20)

   Self.PlaceActorAtMe(myCreature2).StartCombat(game.getplayer())
   Self.PlaceActorAtMe(myCreature1).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature1).StartCombat(game.getplayer())
    Self.PlaceActorAtMe(myCreature6).StartCombat(game.getplayer()) ;BOSS
     Self.PlaceActorAtMe(myCreature7).StartCombat(game.getplayer()) ;BOSS
    Self.PlaceActorAtMe(myCreature8).StartCombat(game.getplayer()) ;BOSS


     Debug.Messagebox("Last Enemy Has Entered The Battle")
 
 Menu()
 
             
EndEvent

Function Menu(Int aiButton = 0)
       aiButton = SSB_AA_RaidMenu.show()   ;Shows Bandit Raid Menu to continue the Raid or startOver
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