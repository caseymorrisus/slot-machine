module SlotMachine.Item exposing (item)

import SlotMachine.Types exposing(..)
import Html exposing (..)
import Html.Attributes exposing (..)

printSymbol : Symbol -> String
printSymbol symbolToPrint =
  case symbolToPrint of
    Cherry -> "Cherry"
    Seven -> "Seven"
    Bar -> "Bar"
    Grapes -> "Grapes"
    Bell -> "Bell"
    NotSpun -> "N/A"

item : Symbol -> Html Msg
item symbol =
  div [ style "marginRight" "10px" ]
    [ text (printSymbol symbol) ]