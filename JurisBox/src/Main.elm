module Main exposing (..)

import Browser
import Css exposing (..)
import Html.Styled exposing (..)
import UI.Styles



---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    styled div
        [ property "display" "grid"
        , property "justify-items" "center"
        , property "grid-template-columns" "1fr"
        , property "grid-template-rows" "4fr 5fr"
        , property "row-gap" "3.25rem"
        , width (pct 100)
        , height (vh 100)
        ]
        []
        [ styled h1
            [ UI.Styles.heading
            , property "align-self" "end"
            ]
            []
            [ text "Descubriendo la Justicia" ]
        , styled
            button
            [ UI.Styles.button
            , property "align-self" "start"
            , width (rem 18)
            , property "display" "grid"
            , property "grid-template-columns" "auto auto"
            , property "align-items" "center"
            , property "justify-content" "center"
            , property "grid-column-gap" "1rem"
            ]
            []
            [ text "Jugar" ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view >> toUnstyled
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
