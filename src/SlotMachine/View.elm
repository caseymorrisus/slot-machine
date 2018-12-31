module SlotMachine.View exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import SlotMachine.Types exposing (..)
import SlotMachine.State exposing (..)
import SlotMachine.SpinButton exposing (spinButton)
import SlotMachine.BetButton exposing (betButton)
import SlotMachine.Result exposing (result)
import SlotMachine.Item exposing (item)

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
    , div [] [ betButton model 1, betButton model 3, betButton model 5]
    , div [ style "marginBottom" "50px" ] [ text ("Score: " ++ String.fromInt model.score) ]
    , div [ style "display" "flex", style "justifyContent" "center" ]
      [ item model.spin.one
      , item model.spin.two
      , item model.spin.three
      ]
    , result model
    , spinButton model
    ]