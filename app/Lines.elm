module Lines exposing (..)

import Html exposing (Html)
import Html.Attributes exposing (style)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Types exposing (..)
import Vectors exposing (..)
import Range exposing (range)
import Direction exposing (..)
import String
import Palette exposing (toCss)


initialViewBox : Rect
initialViewBox =
    { x0 = 0, y0 = 0, x1 = 800, y1 = 800 }


toViewBox : Rect -> String
toViewBox rect =
    [ rect.x0, rect.y0, (rect.x1 - rect.x0), (rect.y1 - rect.y0) ]
        |> List.map toString
        |> String.join " "


lines : Model -> Html msg
lines model =
    svg
        [ width (toString model.size.width)
        , height (toString model.size.height)
        , viewBox ((model.lines |> boundingBox) |> mergeRects initialViewBox |> toViewBox)
        ]
        [ g [] (List.map drawLine model.lines)
          -- , g [] [ boundingBox model.lines |> drawRect ]
          -- , g [] (List.map (toRect >> drawRect) model.lines)
        ]


windRose : Html msg
windRose =
    svg
        [ Html.Attributes.style [ ( "position", "absolute" ), ( "top", "0" ), ( "left", "0" ) ] ]
        [ g [] (List.map (toDirection >> toLine { x = 60, y = 60 } >> drawLine) (range 0 10))
        ]


drawLine : Line -> Svg msg
drawLine line =
    let
        lineStart =
            Vectors.start line

        lineEnd =
            Vectors.end line
    in
        Svg.line
            [ x1 (toString lineStart.x)
            , y1 (toString lineStart.y)
            , x2 (toString lineEnd.x)
            , y2 (toString lineEnd.y)
            , stroke (toCss line.color)
            , strokeWidth "2"
            , strokeLinecap "round"
            ]
            []


drawRect : Rect -> Svg msg
drawRect rect =
    Svg.rect
        [ x (toString rect.x0)
        , y (toString rect.y0)
        , width (toString (rect.x1 - rect.x0))
        , height (toString (rect.y1 - rect.y0))
        , fill "transparent"
        , stroke "black"
        , strokeWidth "1"
        , strokeLinecap "round"
        ]
        []
