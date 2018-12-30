module SpinResult exposing (..)
import SlotMachine exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)

-- view : Model -> Html SlotMachine.Msg
view model =
  div [ style "marginTop" "20px", style "marginBottom" "10px" ]
    [ text (SlotMachine.printResult model) ]
