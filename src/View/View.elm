module View.View exposing (..)
import List exposing(..)
import Html.Attributes exposing (..)
import Html exposing (Html, div, text)
import Models exposing (Game)
import View.Row exposing (makeRow)
import Msgs exposing (Msg)


view :  Game -> Html Msg
view model =
    model.board
       |> indexedMap (\rowIndex c -> makeRow c rowIndex model.turn)
       |> div [class "board"]
