module Msgs exposing (..)

import Models exposing (Player)


type Msg
    = NoOp
    | Place Int Int Player
