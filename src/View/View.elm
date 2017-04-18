module View.View exposing (..)

import List exposing (..)
import Html.Attributes exposing (..)
import Html exposing (Html, div, text)
import Models exposing (Game, Player)
import View.Row exposing (makeRow)
import Msgs exposing (Msg)


view : Game -> Html Msg
view model =
    let
        winner_ =
            case model.winner of
                Just Models.X ->
                    " winner-x"

                Just Models.O ->
                    " winner-o"

                Nothing ->
                    ""
    in
        model.board
            |> indexedMap (\rowIndex rowList -> makeRow rowList rowIndex model.turn)
            |> div [ class ("board" ++ winner_) ]
