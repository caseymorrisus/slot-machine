module SlotMachine.BetButton exposing (betButton)

import SlotMachine.Types exposing(..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

getButtonColor : Model -> Int -> String
getButtonColor model bet =
  if model.bet == bet then
    "#ddd"
  else
    "white"

betButton : Model -> Int -> Html Msg
betButton model bet =
  button
    [ onClick (ChangeBet bet)
    , style "backgroundColor" (getButtonColor model bet)
    , style "border" "1px solid black"
    , style "padding" "5px 10px"
    , style "marginRight" "5px"
    , style "marginBottom" "10px"
    , style "cursor" "pointer"
    ]
    [ text (String.fromInt bet) ]
