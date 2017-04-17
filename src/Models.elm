module Models exposing (..)

type alias Cell
  = Maybe Player

type Player
  = X
  | O

type alias Board =
    List (List Cell)

type alias Game =
  {
  board : Board,
  turn: Player
  }
