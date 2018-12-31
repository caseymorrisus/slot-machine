module SlotMachine.View exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import SlotMachine.Types exposing (..)
import SlotMachine.State exposing (..)

main =
  Browser.element
  { init = init
  , update = update
  , subscriptions = subscriptions
  , view = view
  }

printSymbol : Symbol -> String
printSymbol symbolToPrint =
  case symbolToPrint of
    Cherry -> "Cherry"
    Seven -> "Seven"
    Bar -> "Bar"
    Grapes -> "Grapes"
    Bell -> "Bell"
    NotSpun -> "N/A"

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

getButtonText : Bool -> String
getButtonText hasSpun = if hasSpun then "Spin Again" else "Spin Wheel"

spinButton :  Model -> Html Msg
spinButton model =
  if (model.score - model.bet) >= 0 then
    button
      [ onClick SpinWheels
      , style "border" "1px solid black"
      , style "padding" "10px 15px"
      , style "cursor" "pointer"
      ]
        [ text (getButtonText model.hasSpun) ]
  else
    div [ style "fontWeight" "900" ] [ text (if model.score == 0 then "Game Over" else "Not enough, select smaller bet.") ]

view : Model -> Html Msg
view model =
  div [ style "textAlign" "center" ]
    [ div [ style "fontWeight" "900", style "fontSize" "1.5rem" ] [ text "Bet" ]
    , div [] [ betButton model 1, betButton model 3, betButton model 5]
    , div [ style "marginBottom" "50px" ] [ text ("Score: " ++ String.fromInt model.score) ]
    , div [ style "display" "flex", style "justifyContent" "center" ]
      [ div [ style "marginRight" "10px" ] [ text (printSymbol model.spin.one) ]
      , div [ style "marginRight" "10px" ] [ text (printSymbol model.spin.two) ]
      , div [] [ text (printSymbol model.spin.three) ]
      ]
    , div [ style "marginTop" "50px", style "marginBottom" "10px" ] [ text (printResult model) ]
    , spinButton model
    ]