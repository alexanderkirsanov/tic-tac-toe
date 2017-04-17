module View.Cell exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html exposing (..)
import Msgs exposing (..)
import Models exposing (Cell, Player)

makeCell : Cell -> Int -> Int -> Player -> Html Msg
makeCell cell columnIndex rowIndex action =
    let
        cellClass_ =
              case cell of
                Just Models.X ->
                  "cell cell-X"
                Just Models.O ->
                  "cell cell-O"
                Nothing ->
                  "cell"
    in
    div
        [ onClick (Place columnIndex rowIndex action)
        , class cellClass_
        ]
        []
