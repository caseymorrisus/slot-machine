module SlotMachine.BetButton exposing (view)

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

view : Model -> Int -> Html Msg
view model bet =
  button
    [ onClick (ChangeBet bet)
    , style "backgroundColor" (getButtonColor model bet)
    , style "border" "1px solid black"
    , style "borderRadius" "50%"
    , style "marginRight" "5px"
    , style "marginBottom" "10px"
    , style "cursor" "pointer"
    , style "display" "flex"
    , style "width" "30px"
    , style "height" "30px"
    , style "alignItems" "center"
    , style "justifyContent" "center"
    ]
    [ text (String.fromInt bet) ]
