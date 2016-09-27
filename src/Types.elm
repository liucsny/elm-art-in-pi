module Types exposing (Model, Msg(..))

import Vectors exposing (Position, Line)
import Color exposing (Color)
import Window exposing (Size)
import Direction exposing (Direction)


type alias Model =
    { progress : Int
    , completed : Float
    , current : Int
    , direction : Direction
    , position : Position
    , lines : List Line
    , size : Size
    }


type Msg
    = Next
    | Resize Size
