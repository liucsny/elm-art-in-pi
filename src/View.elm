module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)
import Lines exposing (..)


root : Model -> Html msg
root model =
    div []
        [ lines model
        , logo model
        ]


logo : Model -> Html msg
logo model =
    div [ class "logo" ]
        [ div [ style [ ( "opacity", (toString model.completed) ) ] ] [ text "π" ]
        , div [ class "completed" ] [ ((model.completed * 100) |> floor |> toString) ++ "%" |> text ]
        ]
