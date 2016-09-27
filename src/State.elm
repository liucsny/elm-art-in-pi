module State exposing (..)

import Platform.Cmd as Cmd
import Platform.Sub as Sub
import Time exposing (..)
import Types exposing (..)
import Color exposing (..)
import Vectors exposing (..)
import String
import Pi exposing (getFromPi, pi)
import Direction exposing (..)
import Window exposing (..)
import Task


initialModel : Model
initialModel =
    { progress = 0
    , completed = 0.0
    , position = { x = 200, y = 500 }
    , current = 3
    , direction = toDirection 3
    , lines = []
    , size = Size 0 0
    }


initialCmd : Cmd Msg
initialCmd =
    Task.perform (\_ -> Next) Resize Window.size


progressToDigits : Int -> ( Int, Int )
progressToDigits n =
    ( getFromPi (n - 1), getFromPi n )


update : Msg -> Model -> Model
update msg model =
    let
        newProgress =
            model.progress + 1

        newCurrent =
            getFromPi newProgress

        newDirection =
            toDirection newCurrent

        newLine =
            toLine model.position model.direction
    in
        case msg of
            Next ->
                { model
                    | progress = newProgress
                    , completed = newProgress / (Pi.pi |> String.length |> toFloat)
                    , current = newCurrent
                    , position = end newLine
                    , direction = newDirection
                    , lines = newLine :: model.lines
                }

            Resize size ->
                { model | size = size }


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.progress < String.length Pi.pi then
        Sub.batch
            [ Window.resizes Resize
            , every (second / 60) (\_ -> Next)
            ]
    else
        Window.resizes Resize
