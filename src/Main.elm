module Main exposing (..)

import Html exposing (Html, div, text, program)
import Msgs exposing (Msg)
import Models exposing (Game, Player)
import Update exposing (update)
import View.View exposing (view)


game : Game
game =
    { board = List.repeat 3 (List.repeat 3 Nothing)
    , turn = Models.X
    }


init : ( Game, Cmd Msg )
init =
    ( game, Cmd.none )


subscriptions : Game -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Game Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
