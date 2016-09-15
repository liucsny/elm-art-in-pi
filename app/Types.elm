module Types exposing (Model, Msg(..), Direction)

import Vectors exposing (Position, Line)
import Color exposing (Color)


type alias Direction =
    { angle : Float
    , color : Color
    }


type alias Model =
    { progress : Int
    , current : Int
    , direction : Direction
    , position : Position
    , lines : List Line
    , initialLines : List Line
    }


type Msg
    = Next
