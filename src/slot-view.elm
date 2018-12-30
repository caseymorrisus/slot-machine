import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random
import SlotMachine exposing(..)
import SpinButton
import SpinItem
import SpinResult


-- MAIN

main =
  Browser.element
  { init = init
  , update = update
  , subscriptions = subscriptions
  , view = view
  }


-- MODEL

type alias Model =
  { spin: Spin
  , hasSpun: Bool
  , score : Int
  , bet : Int
  }

init : () -> (Model, Cmd SlotMachine.Msg)
init _ =
  ( Model SlotMachine.initial False 100 1
  , Cmd.none
  )


-- UPDATE

getNewScore : Model -> SlotMachine.Spin -> Int
getNewScore model newSpin =
  model.score + SlotMachine.getPrizeFromSpin newSpin model.bet

update : SlotMachine.Msg -> Model -> (Model, Cmd SlotMachine.Msg)
update msg model =
  case msg of
    SpinWheels ->
      ( Model model.spin True (model.score - model.bet) model.bet
      , Random.generate NewSpin SlotMachine.spin
      )
    NewSpin newSpin ->
      ( Model newSpin True (getNewScore model newSpin) model.bet
      , Cmd.none
      )
    ChangeBet newBet ->
      ( Model model.spin model.hasSpun model.score newBet
      , Cmd.none
      )


-- SUBSCRIPTIONS

subscriptions : Model -> Sub SlotMachine.Msg
subscriptions model =
  Sub.none


-- VIEW

getButtonColor : Model -> Int -> String
getButtonColor model bet =
  if model.bet == bet then
    "#ddd"
  else
    "white"


betButton : Model -> Int -> Html SlotMachine.Msg
betButton model bet =
  button
    [ onClick (ChangeBet bet)
    , style "backgroundColor" (getButtonColor model bet)
    , style "border" "none"
    , style "padding" "5px 10px"
    , style "marginRight" "5px"
    , style "marginBottom" "10px"
    ]
    [ text (String.fromInt bet) ]

view : Model -> Html SlotMachine.Msg
view model =
  div [ style "textAlign" "center" ]
    [ div [] [ text "Bet" ]
    , div [] [ betButton model 1, betButton model 2, betButton model 3]
    , div [ style "marginBottom" "20px" ] [ text ("Score: " ++ String.fromInt model.score) ]
    , div [ style "display" "flex", style "justifyContent" "center" ]
      [ SpinItem.view model.spin.one
      , SpinItem.view model.spin.two
      , SpinItem.view model.spin.three
      ]
    , SpinResult.view model
    , SpinButton.view SpinWheels model.hasSpun model.score
    ]
