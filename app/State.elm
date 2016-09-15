module State exposing (..)

import Platform.Cmd as Cmd
import Platform.Sub as Sub
import Time exposing (..)
import Types exposing (..)
import Array exposing (..)
import Color exposing (..)
import Vectors exposing (..)
import String
import Pi exposing (getFromPi, pi)


palette : Array Color
palette =
    fromList
        [ rgb 240 187 26
        , rgb 235 154 15
        , rgb 229 62 41
        , rgb 208 0 59
        , rgb 173 7 96
        , rgb 145 63 147
        , rgb 82 86 171
        , rgb 26 133 152
        , rgb 18 166 100
        , rgb 124 182 80
        ]
{-
palette =
    fromList
        [ white
        , lightGrey
        , grey
        , darkGrey
        , lightCharcoal
        , charcoal
        , darkCharcoal
        , black
        , red
        , lightRed
        ]
-}


defaultColor : Color
defaultColor =
    rgb 240 187 26


numberToDegrees : Int -> Float
numberToDegrees x =
    toFloat (x * 360 // 10 - 90)


toDirection : Int -> Direction
toDirection x =
    case get x palette of
        Just color ->
            { angle = x |> numberToDegrees |> degrees, color = color }

        Nothing ->
            { angle = x |> numberToDegrees |> degrees, color = defaultColor }


range : Int -> Int -> List Int
range start end =
    if start < end then
        start :: range (start + 1) end
    else
        []


initialModel : Model
initialModel =
    { progress = 0
    , position = { x = 200, y = 500 }
    , current = 3
    , direction = toDirection 3
    , lines = []
    , initialLines = List.map (toDirection >> toLine { x = 60, y = 60 }) (range 0 10)
    }


toVector : Direction -> Vector
toVector direction =
    { length = 50, angle = direction.angle }


toLine : Position -> Direction -> Line
toLine position direction =
    { position = position, vector = toVector direction, color = direction.color }


initialCmd : Cmd Msg
initialCmd =
    Cmd.none


progressToDigits : Int -> ( Int, Int )
progressToDigits n =
    ( getFromPi (n - 1), getFromPi n )


update : Msg -> Model -> ( Model, Cmd Msg )
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
                ( { model
                    | progress = newProgress
                    , current = newCurrent
                    , position = end newLine
                    , direction = newDirection
                    , lines = newLine :: model.lines
                  }
                , Cmd.none
                )


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.progress < String.length Pi.pi then
        every (1 * millisecond) (\_ -> Next)
    else
        Sub.none
