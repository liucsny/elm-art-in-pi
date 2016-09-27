module Palette exposing (palette, toCss)

import Array exposing (..)
import Color exposing (..)
import String


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
