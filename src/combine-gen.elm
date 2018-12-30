import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Random
import Enemies exposing (Enemy, randomEnemies)


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
  { enemies: List Enemy
  }

init : () -> (Model, Cmd Msg)
init _ =
  (Model []
  , Random.generate NewEnemies randomEnemies
  )


-- UPDATE

type Msg =
  GenerateEnemies |
  NewEnemies (List Enemy)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GenerateEnemies ->
      ( model
      , Random.generate NewEnemies randomEnemies
      )
    NewEnemies newEnemies ->
      ( Model newEnemies
      , Cmd.none
      )


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW

header = h2 [] [ text "Enemies" ]
renderRow label prop =
  div [] [ text (label ++ ": " ++ String.fromFloat prop)]

renderEnemies enemies =
  ul []
    (List.map (\l -> li [] [ div [] [
      renderRow "health" l.health,
      renderRow "x" l.x,
      renderRow "y" l.y
    ] ]) enemies)

view : Model -> Html Msg
view model =
  div []
    [ header
    , button [ onClick GenerateEnemies ] [ text "New Enemies" ]
    , renderEnemies model.enemies
    ]