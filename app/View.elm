module View exposing (..)

import Html exposing (Html, div, text)
import String
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Types exposing (..)
import Vectors exposing (..)
import Color exposing (..)


toList : Color -> List String
toList color =
    let
        rgb =
            toRgb color
    in
        List.map toString [ rgb.red, rgb.green, rgb.blue ]


toCss : Color -> String
toCss color =
    String.concat [ "rgb(", (toList color |> String.join ", "), ")" ]


root : Model -> Html msg
root model =
    -- model |> toString |> Html.text
    lines model

toViewBox : Rect -> String
toViewBox rect =
    [rect.x0, rect.y0, (rect.x1 - rect.x0), (rect.y1 - rect.y0)]
        |> List.map toString
        |> String.join " " 

initialViewBox : Rect
initialViewBox = {x0 = 0, y0 = 0, x1 = 800, y1 = 800}

lines : Model -> Html msg
lines model =
    svg
        [ width "100%"
        , height "800px"
        , viewBox ((model.lines |> boundingBox) |>  mergeRects initialViewBox |> toViewBox)
        ]
        [ g [] (List.map drawLine model.lines)
        , g [] (List.map drawLine model.initialLines)
        -- , g [] [ boundingBox model.lines |> drawRect ]
        -- , g [] (List.map (toRect >> drawRect) model.lines)
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
