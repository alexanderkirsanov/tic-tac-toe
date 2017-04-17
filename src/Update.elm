module Update exposing (..)

import Msgs exposing (Msg(..))
import Models exposing (Game, Player)


update : Msg -> Game -> ( Game, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
        Place x y player->
            ( updateGameState model x y player, Cmd.none )

updateGameState: Game -> Int -> Int -> Player -> Game
updateGameState model row column player =
    let
        turn =
              case player of
                  Models.X ->
                      Models.O
                  Models.O ->
                      Models.X
        mPlayer = Just(player)
    in
        {model
            | turn = turn,
              board = updateCell model.board row column mPlayer}

updateCell : List (List(Models.Cell)) -> Int -> Int -> Models.Cell -> List (List(Models.Cell))
updateCell list row column value =
        List.indexedMap (\rowIndex element ->
            if rowIndex == row
                then updateCellInRow element column value
                else element) list


updateCellInRow : List Models.Cell -> Int -> Models.Cell -> List Models.Cell
updateCellInRow list column value = List.indexedMap (\colIndex element ->
    if colIndex == column
        then value
        else element) list
