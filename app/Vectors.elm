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


vectorBetween : Position -> Position -> Vector
vectorBetween p1 p2 =
    let
        dx =
            p2.x - p1.x

        dy =
            p2.y - p1.y
    in
        { length = sqrt (dx ^ 2 + dy ^ 2)
        , angle = atan2 dy dx
        }


addToAngle : Float -> Line -> Line
addToAngle delta line =
    let
        vector =
            line.vector
    in
        { line | vector = { vector | angle = vector.angle + delta } }


components : Line -> { dx : Float, dy : Float }
components line =
    { dx = cos line.vector.angle
    , dy = sin line.vector.angle
    }


withLength : Float -> Line -> Line
withLength length line =
    let
        vector =
            line.vector
    in
        { line | vector = { vector | length = length } }


boundingBox : List Line -> Rect
boundingBox lines =
    case lines of
        [] ->
            { x0 = 0, y0 = 0, x1 = 0, y1 = 0 }

        line :: rest ->
            List.foldl (\a b -> mergeRects (toRect a) b)  (toRect line) rest


mergeRects : Rect -> Rect -> Rect
mergeRects a b =
    { x0 = min a.x0 b.x0, y0 = min a.y0 b.y0, x1 = max a.x1 b.x1, y1 = max a.y1 b.y1}


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
