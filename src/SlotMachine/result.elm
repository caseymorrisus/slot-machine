module SlotMachine.Result exposing (result)

import SlotMachine.Types exposing (..)
import SlotMachine.State exposing (didWin, getPrize)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

printResult model =
  case model.hasSpun of
    True ->
      if didWin model.spin then
        "You won: " ++ String.fromInt (getPrizeFromSpin model.spin model.bet) ++ " points"
      else
        "You lost, try again."
    False ->
      "Please spin the wheel."

getPrizeFromSpin : Spin -> Int -> Int
getPrizeFromSpin spinToTest bet =
  if didWin spinToTest then
    (getPrize spinToTest.one) * bet
  else
    0

result : Model -> Html Msg
result model =
  div [ style "marginTop" "50px", style "marginBottom" "10px" ]
    [ text (printResult model) ]
