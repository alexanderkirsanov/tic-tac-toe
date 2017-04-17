module View.Cell exposing (..)

import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html exposing (..)
import Msgs exposing (..)
import Models exposing (Cell, Player)


makeCell : Cell -> Int -> Int -> Player -> Html Msg
makeCell cell columnIndex rowIndex action =
    let
        ( cellClass_, action_ ) =
            case cell of
                Just Models.X ->
                    ( "cell cell-X", NoOp )

                Just Models.O ->
                    ( "cell cell-O", NoOp )

                Nothing ->
                    ( "cell", Place columnIndex rowIndex action )
    in
        div
            [ onClick (action_)
            , class cellClass_
            ]
            []
