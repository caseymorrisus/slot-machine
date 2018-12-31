module SlotMachine.View exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import SlotMachine.Types exposing (..)
import SlotMachine.State exposing (..)
import SlotMachine.SpinButton as SpinButton
import SlotMachine.BetButton as BetButton
import SlotMachine.Result as Result
import SlotMachine.Item as Item

main =
  Browser.element
  { init = init
  , update = update
  , subscriptions = subscriptions
  , view = view
  }


view : Model -> Html Msg
view model =
  div [ style "textAlign" "center" ]
    [ div
      [ style "fontWeight" "900", style "fontSize" "1.5rem", style "marginBottom" "5px" ]
      [ text "Bet" ]
    , div [ style "display" "flex", style "justifyContent" "center" ]
      [ BetButton.view model 1, BetButton.view model 3, BetButton.view model 5]
    , div [ style "marginBottom" "50px" ] [ text ("Score: " ++ String.fromInt model.score) ]
    , div [ style "display" "flex", style "justifyContent" "center" ]
      [ Item.view model.spin.one
      , Item.view model.spin.two
      , Item.view model.spin.three
      ]
    , Result.view model
    , SpinButton.view model
    ]