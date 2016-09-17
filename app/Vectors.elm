module Vectors exposing (..)

import Color exposing (Color)


type alias Position =
    { x : Float
    , y : Float
    }


type alias Rect =
    { x0 : Float
    , y0 : Float
    , x1 : Float
    , y1 : Float
    }


type alias Vector =
    { length : Float
    , angle : Float
    }


type alias Line =
    { position : Position
    , vector : Vector
    , color : Color
    }


start : Line -> Position
start =
    .position


end : Line -> Position
end line =
    let
        ( dx, dy ) =
            fromPolar ( line.vector.length, line.vector.angle )
    in
        { x = line.position.x + dx
        , y = line.position.y + dy
        }


boundingBox : List Line -> Rect
boundingBox lines =
    case lines of
        [] ->
            { x0 = 0, y0 = 0, x1 = 0, y1 = 0 }

        line :: rest ->
            List.foldl (\a b -> mergeRects (toRect a) b) (toRect line) rest


mergeRects : Rect -> Rect -> Rect
mergeRects a b =
    { x0 = min a.x0 b.x0, y0 = min a.y0 b.y0, x1 = max a.x1 b.x1, y1 = max a.y1 b.y1 }


toRect : Line -> Rect
toRect line =
    let
        startPosition =
            start line

        endPosition =
            end line
    in
        case ( startPosition.x < endPosition.x, startPosition.y < endPosition.y ) of
            ( True, True ) ->
                { x0 = startPosition.x, y0 = startPosition.y, x1 = endPosition.x, y1 = endPosition.y }

            ( False, True ) ->
                { x0 = endPosition.x, y0 = startPosition.y, x1 = startPosition.x, y1 = endPosition.y }

            ( False, False ) ->
                { x0 = endPosition.x, y0 = endPosition.y, x1 = startPosition.x, y1 = startPosition.y }

            ( True, False ) ->
                { x0 = startPosition.x, y0 = endPosition.y, x1 = endPosition.x, y1 = startPosition.y }
