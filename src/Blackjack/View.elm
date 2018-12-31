module Blackjack.View exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Blackjack.Types exposing (..)
import Blackjack.State exposing (..)

displayRank : Rank -> String
displayRank rank =
  case rank of
    Ace -> "Ace"
    Two -> "Two"
    Three -> "Three"
    Four -> "Four"
    Five -> "Five"
    Six -> "Six"
    Seven -> "Seven"
    Eight -> "Eight"
    Nine -> "Nine"
    Ten -> "Ten"
    Jack -> "Jack"
    Queen -> "Queen"
    King -> "King"

displaySuit : Suit -> String
displaySuit suit =
  case suit of
    Spades -> "Spades"
    Diamonds -> "Diamonds"
    Hearts -> "Hearts"
    Clubs -> "Clubs"

displayCard : Card -> String
displayCard (rank, suit) =
  displayRank rank ++ " of " ++ displaySuit suit

main =
  Browser.element
  { init = init
  , update = update
  , subscriptions = subscriptions
  , view = view
  }

displayHand hand =
  List.map (\card -> div [] [ text (displayCard card) ]) hand

view : Model -> Html Msg
view model =
  div [ style "textAlign" "center" ]
    [ button [ onClick ShuffleDeck ] [ text "Shuffle Deck" ]
    , div [] (displayHand model.deck)
    ]
