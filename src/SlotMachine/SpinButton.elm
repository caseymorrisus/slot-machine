module SlotMachine.SpinButton exposing (view)

import SlotMachine.Types exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

getButtonText : Bool -> String
getButtonText hasSpun = if hasSpun then "Spin Again" else "Spin Wheel"

view :  Model -> Html Msg
view model =
  if (model.score - model.bet) >= 0 then
    button
      [ onClick SpinWheels
      , style "border" "1px solid black"
      , style "padding" "10px 15px"
      , style "cursor" "pointer"
      , style "textTransform" "uppercase"
      , style "fontWeight" "900"
      ]
        [ text (getButtonText model.hasSpun) ]
  else
    div [ style "fontWeight" "900" ] [ text (if model.score == 0 then "Game Over" else "Not enough, select smaller bet.") ]
