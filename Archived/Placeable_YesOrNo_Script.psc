Scriptname Placeable_YesOrNo_Script extends activemagiceffect  

; BELL: I LIKE your array experiment!
 

Message[] Property OutputMessages  Auto
Message Property Ask01  Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

   If OutputMessages

      Ask01.Show()
      Utility.Wait(0.3)
      Debug.Messagebox("Your Answer Is..")
      Utility.Wait(0.1)

      Int YesorNo = Utility.RandomInt(0, (OutputMessages.Length - 1)) ; BELL: Modified to give you more possible options!
      OutputMessages[YesorNo].Show(YesorNo)

   EndIf

EndEvent