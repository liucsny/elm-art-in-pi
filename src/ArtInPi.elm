module ArtInPi exposing (main)

{-| View showing π as colourful lines.

@docs main
-}

import Html.App
import State exposing (..)
import View exposing (..)


{-| Initialize program
-}
main : Program Never
main =
    Html.App.program
        { init = ( State.initialModel, State.initialCmd )
        , subscriptions = State.subscriptions
        , update = \msg model -> ( State.update msg model, Cmd.none )
        , view = View.root
        }
