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
  NumRank Int |
  Ace |
  Jack |
  Queen |
  King

type alias Card = (Rank, Suit)

type alias Hand = List Card
