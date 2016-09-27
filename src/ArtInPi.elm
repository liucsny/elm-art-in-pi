module ArtInPi exposing (main)

import Html.App
import State exposing (..)
import View exposing (..)


main : Program Never
main =
    Html.App.program
        { init = ( State.initialModel, State.initialCmd )
        , subscriptions = State.subscriptions
        , update = \msg model -> ( State.update msg model, Cmd.none )
        , view = View.root
        }
