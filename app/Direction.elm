module Direction exposing (..)

import Vectors exposing (..)
import Palette exposing (..)
import Array
import Color exposing (Color)


type alias Direction =
    { angle : Float
    , color : Color
    }


toDirection : Int -> Direction
toDirection x =
    case Array.get x palette of
        Just color ->
            { angle = x |> numberToDegrees |> degrees, color = color }

        Nothing ->
            { angle = x |> numberToDegrees |> degrees, color = Color.black }


numberToDegrees : Int -> Float
numberToDegrees x =
    toFloat (x * 360 // 10 - 90)


toVector : Direction -> Vector
toVector direction =
    { length = 50, angle = direction.angle }


toLine : Position -> Direction -> Line
toLine position direction =
    { position = position, vector = toVector direction, color = direction.color }
