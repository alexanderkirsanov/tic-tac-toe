module Update exposing (..)

import Msgs exposing (Msg(..))
import Models exposing (Game, Player)


update : Msg -> Game -> ( Game, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Place x y player ->
            ( updateGameState model x y player
                |> checkWinner
            , Cmd.none
            )


check : ( Models.Cell, Models.Cell, Models.Cell ) -> Maybe Player
check tuple =
    case tuple of
        ( Just Models.X, Just Models.X, Just Models.X ) ->
            Just Models.X

        ( Just Models.O, Just Models.O, Just Models.O ) ->
            Just Models.O

        ( _, _, _ ) ->
            Nothing


checkWinner : Game -> Game
checkWinner game =
    let
        winner_ =
            [ check ( getCellValue ( 1, 1, game.board ), getCellValue ( 1, 2, game.board ), getCellValue ( 1, 3, game.board ) )
            , check ( getCellValue ( 2, 1, game.board ), getCellValue ( 2, 2, game.board ), getCellValue ( 2, 3, game.board ) )
            , check ( getCellValue ( 3, 1, game.board ), getCellValue ( 3, 2, game.board ), getCellValue ( 3, 3, game.board ) )
            , check ( getCellValue ( 1, 1, game.board ), getCellValue ( 2, 1, game.board ), getCellValue ( 3, 1, game.board ) )
            , check ( getCellValue ( 1, 2, game.board ), getCellValue ( 2, 2, game.board ), getCellValue ( 3, 2, game.board ) )
            , check ( getCellValue ( 1, 3, game.board ), getCellValue ( 2, 3, game.board ), getCellValue ( 3, 3, game.board ) )
            , check ( getCellValue ( 1, 1, game.board ), getCellValue ( 2, 2, game.board ), getCellValue ( 3, 3, game.board ) )
            , check ( getCellValue ( 3, 1, game.board ), getCellValue ( 2, 2, game.board ), getCellValue ( 1, 3, game.board ) )
            ]
                |> List.filter (\a -> a /= Nothing)
                |> List.head
    in
        { game
            | winner =
                case winner_ of
                    Just value ->
                        value

                    Nothing ->
                        game.winner
        }


get : Int -> List a -> Maybe a
get index list =
    if (List.length list) >= index then
        List.take index list
            |> List.reverse
            |> List.head
    else
        Nothing


cellFromMaybe : Maybe Models.Cell -> Models.Cell
cellFromMaybe result =
    Maybe.withDefault Nothing result


getCellValue : ( Int, Int, List (List Models.Cell) ) -> Models.Cell
getCellValue =
    cellFromMaybe << getCell


getCell : ( Int, Int, List (List a) ) -> Maybe a
getCell ( row, column, list ) =
    let
        row_ =
            get row list
    in
        case row_ of
            Just value ->
                get column value

            Nothing ->
                Nothing


updateCell : Int -> Int -> List (List Models.Cell) -> Models.Cell -> List (List Models.Cell)
updateCell row column list value =
    List.indexedMap
        (\rowIndex element ->
            if rowIndex == row then
                updateCellInRow column element value
            else
                element
        )
        list


updateCellInRow : Int -> List Models.Cell -> Models.Cell -> List Models.Cell
updateCellInRow column list value =
    List.indexedMap
        (\colIndex element ->
            if colIndex == column then
                value
            else
                element
        )
        list


updateGameState : Game -> Int -> Int -> Player -> Game
updateGameState model row column turn =
    let
        turn_ =
            case turn of
                Models.X ->
                    Models.O

                Models.O ->
                    Models.X

        action_ =
            Just (turn)
    in
        { model
            | turn = turn_
            , board = updateCell row column model.board action_
        }
