module Enemies exposing (..)
import Random

type alias Enemy =
  { health : Float
  , rotation : Float
  , x : Float
  , y : Float
  }

enemy : Random.Generator Enemy
enemy =
  Random.map2
    (\x y -> Enemy 100 0 x y)
    (Random.float 0 100)
    (Random.float 0 100)

randomEnemies : Random.Generator (List Enemy)
randomEnemies =
  Random.int 5 10
    |> Random.andThen (\num -> Random.list num enemy)
