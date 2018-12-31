module SlotMachine.Types exposing (..)

type alias Model =
  { spin: Spin
  , hasSpun: Bool
  , score : Int
  , bet : Int
  }

type Msg =
  SpinWheels |
  NewSpin Spin |
  ChangeBet Int

type Symbol = Cherry | Grapes | Seven | Bar | Bell | NotSpun

type alias Spin =
  { one : Symbol
  , two : Symbol
  , three : Symbol
  }
