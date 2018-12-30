module SlotMachine exposing (..)
import Random

description = "Contains logic for slot machine game."

type Msg =
  SpinWheels |
  NewSpin Spin |
  ChangeBet Int

type Symbol = Cherry | Grapes | Seven | Bar | Bell | NotSpun

symbol : Random.Generator Symbol
symbol =
  Random.weighted (40, Cherry) [ (5, Seven), (15, Bar), (35, Grapes), (15, Bell) ]

printSymbol : Symbol -> String
printSymbol symbolToPrint =
  case symbolToPrint of
    Cherry -> "Cherry"
    Seven -> "Seven"
    Bar -> "Bar"
    Grapes -> "Grapes"
    Bell -> "Bell"
    NotSpun -> "N/A"

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

getPrizeFromSpin : Spin -> Int -> Int
getPrizeFromSpin spinToTest bet =
  if didWin spinToTest then
    (getPrize spinToTest.one) * bet
  else
    0

-- printResult : Bool -> Spin -> String
printResult model =
  case model.hasSpun of
    True ->
      if didWin model.spin then
        "You won: " ++ String.fromInt (getPrizeFromSpin model.spin model.bet) ++ " points"
      else
        "You lost."
    False ->
      "Please spin the wheel."

type alias Spin =
  { one : Symbol
  , two : Symbol
  , three : Symbol
  }

spin : Random.Generator Spin
spin =
  Random.map3 Spin symbol symbol symbol

initial : Spin
initial =
  { one = NotSpun
  , two = NotSpun
  , three = NotSpun
  }
