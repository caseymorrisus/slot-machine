module SpinButton exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import SlotMachine

getButtonText : Bool -> String
getButtonText hasSpun = if hasSpun then "Spin Again" else "Spin Wheel"

view : SlotMachine.Msg -> Bool -> Int -> Html SlotMachine.Msg
view handleClick hasSpun score =
  if score > 0 then
    button [ onClick handleClick ] [ text (getButtonText hasSpun) ]
  else
    div [ style "fontWeight" "900" ] [ text "Game Over" ]
