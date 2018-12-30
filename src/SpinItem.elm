module SpinItem exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import SlotMachine

view : SlotMachine.Symbol -> Html SlotMachine.Msg
view symbol =
  div [ style "marginRight" "10px" ]
    [ text (SlotMachine.printSymbol symbol) ]
