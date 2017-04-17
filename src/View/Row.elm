module View.Row exposing (..)
import List exposing(..)
import Html exposing (Html, div, text)
import View.Cell exposing (makeCell)
import Msgs exposing (Msg)
import Models exposing (Cell, Player)


makeRow :  List Cell -> Int -> Player -> Html Msg
makeRow row rowIndex action =
    row
       |> indexedMap (\cellIndex cellModel -> makeCell cellModel rowIndex cellIndex action)
       |> div []
