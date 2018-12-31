module Blackjack.Types exposing (..)

type alias Model =
  { deck: List Card
  , dealer: Hand
  , player : Hand
  }

type Msg =
  ShuffleDeck |
  NewDeck (List Card)

type Suit = Spades | Hearts | Diamonds | Clubs

type Rank =
  Ace |
  Two |
  Three |
  Four |
  Five |
  Six |
  Seven |
  Eight |
  Nine |
  Ten |
  Jack |
  Queen |
  King

type alias Card = (Rank, Suit)

type alias Hand = List Card
