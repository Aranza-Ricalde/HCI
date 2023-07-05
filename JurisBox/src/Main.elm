module Main exposing (..)

import Browser
import Css exposing (..)
import Html.Styled exposing (..)
import Material.Icons as Filled
import Material.Icons.Types exposing (Coloring(..))
import Set exposing (Set)
import Svg.Styled
import UI.Styles



---- MODEL ----


type alias Box =
    { question : String
    , correctAnswer : String
    , falseAnswers : ( String, String, String )
    }


boxes : List Box
boxes =
    [ Box
        "Es un proceso en el que se decide si alguien ha hecho algo malo o no"
        "Juicio"
        ( "Juez", "Fiscalía", "Abuso" )
    , Box
        "Persona que se encarga de escuchar a todas las personas involucradas en una situación y este decide cómo resolver el problema"
        "Juez"
        ( "Fiscalía", "Sentencia", "Delito" )
    , Box
        "Es cuando alguien hace algo malo que puede lastimar a otras personas o causar problemas que están en contra de las reglas de la sociedad"
        "Delito"
        ( "Denuncia", "Sentencia", "Declaración" )
    , Box
        "Cuando alguien lastima a una persona de forma física o mental"
        "Abuso"
        ( "Declaración", "Juicio", "Denuncia" )
    , Box
        "Es cuando alguien le cuenta a una autoridad sobre algo malo que le ha sucedido o ha visto que le ha pasado a otra persona"
        "Denuncia"
        ( "Declaración", "Juez", "Juicio" )
    , Box
        "Grupo de personas que se encargan de investigar cosas malas que suceden a las personas, asegurándose que haya justicia"
        "Fiscalía"
        ( "Sentencia", "Juicio", "Declaración" )
    ]


type CurrentPage
    = StartPage
    | BoxesHub
    | BoxPrompt
    | SuccessMessage
    | ErrorMessage


type alias Model =
    { currentPage : CurrentPage
    , answeredBoxes : Set Box
    }


init : ( Model, Cmd Msg )
init =
    ( { currentPage = StartPage
      , answeredBoxes = Set.empty
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    case model.currentPage of
        StartPage ->
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
                    [ text "Jugar"
                    , styled div
                        [ position relative, width (px 16) ]
                        []
                        [ styled div
                            [ position absolute
                            , property "display" "grid"
                            , top (pct 50)
                            , transform (translateY (pct -50))
                            ]
                            []
                            [ Svg.Styled.fromUnstyled (Filled.chevron_right 48 Inherit)
                            ]
                        ]
                    ]
                ]

        BoxesHub ->
            if Set.size model.answeredBoxes /= List.length boxes then
                text "TODO: Boxes hub"

            else
                text "TODO: Game finished message"

        BoxPrompt ->
            text "TODO: Box prompt"

        SuccessMessage ->
            text "TODO: Success message"

        ErrorMessage ->
            text "TODO: Error message"



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view >> toUnstyled
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
