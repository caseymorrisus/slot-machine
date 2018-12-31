module Blackjack.State exposing (..)

import Blackjack.Types exposing (..)
import Random
import Random.List exposing (..)

-- initialDeck = [(2, Hearts), (5, Diamonds)]

suits : List Suit
suits = [ Spades, Hearts, Diamonds, Clubs ]

ranks : List Rank
ranks = [ Ace, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King ]

getRankAndSuit : Suit -> List Card
getRankAndSuit suit = List.map (\rank -> (rank, suit)) ranks

getDeck : List Card
getDeck = List.foldr (++) []
  [ getRankAndSuit Spades
  , getRankAndSuit Hearts
  , getRankAndSuit Diamonds
  , getRankAndSuit Clubs
  ]

getRandomDeck = shuffle getDeck

init : () -> (Model, Cmd Msg)
init _ =
  ( Model [] [] []
  , Random.generate NewDeck getRandomDeck
  )

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ShuffleDeck ->
      ( model
      , Random.generate NewDeck getRandomDeck
      )
    NewDeck newDeck ->
      ( Model newDeck model.player model.dealer
      , Cmd.none
      )

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
