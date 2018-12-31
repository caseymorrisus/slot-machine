module SlotMachine.State exposing (init, update, subscriptions, didWin, getPrize)

import Random
import SlotMachine.Types exposing (..)

initialScore = 100

initialSpin : Spin
initialSpin =
  { one = NotSpun
  , two = NotSpun
  , three = NotSpun
  }

init : () -> (Model, Cmd Msg)
init _ =
  ( Model initialSpin False initialScore 1
  , Cmd.none
  )

getPrize : Symbol -> Int
getPrize symbolToTest =
  case symbolToTest of
    Cherry -> 10
    Seven -> 1000
    Bar -> 100
    Grapes -> 8
    Bell -> 90
    NotSpun -> 0

didWin : Spin -> Bool
didWin {one,two,three} = one == two && two == three

getScoreFromSpin : Spin -> Int -> Int
getScoreFromSpin spinToTest bet =
  if didWin spinToTest then
    (getPrize spinToTest.one) * bet
  else
    0

getNewScore : Model -> Spin -> Int
getNewScore model newSpin =
  model.score + getScoreFromSpin newSpin model.bet

symbol : Random.Generator Symbol
symbol =
  Random.weighted (40, Cherry) [ (5, Seven), (15, Bar), (35, Grapes), (15, Bell) ]

spin : Random.Generator Spin
spin =
  Random.map3 Spin symbol symbol symbol

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    SpinWheels ->
      ( Model model.spin True (model.score - model.bet) model.bet
      , Random.generate NewSpin spin
      )
    NewSpin newSpin ->
      ( Model newSpin True (getNewScore model newSpin) model.bet
      , Cmd.none
      )
    ChangeBet newBet ->
      ( Model model.spin model.hasSpun model.score newBet
      , Cmd.none
      )

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
