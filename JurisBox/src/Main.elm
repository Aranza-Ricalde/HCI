module Main exposing (..)

import Browser
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Events exposing (onClick)
import Material.Icons as Filled
import Material.Icons.Types exposing (Coloring(..))
import Random
import Random.List
import Set exposing (Set)
import Svg.Styled as Svg
import Svg.Styled.Attributes as SvgAttr
import UI.Styles



---- MODEL ----


type alias Box =
    { question : String
    , correctAnswer : String
    , falseAnswers : List String
    }


boxes : List Box
boxes =
    [ Box
        "Es un proceso en el que se decide si alguien ha hecho algo malo o no"
        "Juicio"
        [ "Juez", "Fiscalía", "Abuso" ]
    , Box
        "Persona que se encarga de escuchar a todas las personas involucradas en una situación y este decide cómo resolver el problema"
        "Juez"
        [ "Fiscalía", "Sentencia", "Delito" ]
    , Box
        "Es cuando alguien hace algo malo que puede lastimar a otras personas o causar problemas que están en contra de las reglas de la sociedad"
        "Delito"
        [ "Denuncia", "Sentencia", "Declaración" ]
    , Box
        "Cuando alguien lastima a una persona de forma física o mental"
        "Abuso"
        [ "Declaración", "Juicio", "Denuncia" ]
    , Box
        "Es cuando alguien le cuenta a una autoridad sobre algo malo que le ha sucedido o ha visto que le ha pasado a otra persona"
        "Denuncia"
        [ "Declaración", "Juez", "Juicio" ]
    , Box
        "Grupo de personas que se encargan de investigar cosas malas que suceden a las personas, asegurándose que haya justicia"
        "Fiscalía"
        [ "Sentencia", "Juicio", "Declaración" ]
    ]


type alias BoxPromptData =
    { box : Box
    , options : List String
    , attemptedOptions : Set String
    }


type CurrentPage
    = InitialPage
    | BoxesHub
    | BoxPrompt BoxPromptData
    | SuccessMessage
    | ErrorMessage BoxPromptData


type alias Model =
    { currentPage : CurrentPage
    , answeredBoxes : Set String
    }


init : ( Model, Cmd Msg )
init =
    ( { currentPage = InitialPage
      , answeredBoxes = Set.empty
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = StartGame
    | SelectBox Box
    | ShuffleBoxOptions Box (List String)
    | SelectAnswer BoxPromptData String
    | ContinueFromSuccessMessage
    | ContinueFromErrorMessage BoxPromptData


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartGame ->
            ( { model | currentPage = BoxesHub }
            , Cmd.none
            )

        SelectBox box ->
            ( model
            , Random.generate
                (ShuffleBoxOptions box)
                (Random.List.shuffle (box.correctAnswer :: box.falseAnswers))
            )

        ShuffleBoxOptions box options ->
            ( { model
                | currentPage =
                    BoxPrompt
                        { box = box
                        , options = options
                        , attemptedOptions = Set.empty
                        }
              }
            , Cmd.none
            )

        SelectAnswer { box, options, attemptedOptions } selectedAnswer ->
            ( if selectedAnswer == box.correctAnswer then
                { answeredBoxes = Set.insert box.correctAnswer model.answeredBoxes
                , currentPage = SuccessMessage
                }

              else
                { model
                    | currentPage =
                        ErrorMessage
                            { attemptedOptions = Set.insert selectedAnswer attemptedOptions
                            , box = box
                            , options = options
                            }
                }
            , Cmd.none
            )

        ContinueFromSuccessMessage ->
            ( { model | currentPage = BoxesHub }
            , Cmd.none
            )

        ContinueFromErrorMessage boxPromptData ->
            ( { model | currentPage = BoxPrompt boxPromptData }
            , Cmd.none
            )



---- VIEW ----


view : Model -> Html Msg
view model =
    case model.currentPage of
        InitialPage ->
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
                    [ onClick StartGame ]
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
                            [ Svg.fromUnstyled (Filled.chevron_right 48 Inherit)
                            ]
                        ]
                    ]
                ]

        BoxesHub ->
            if Set.size model.answeredBoxes /= List.length boxes then
                styled div
                    [ property "display" "grid"
                    , property "justify-items" "center"
                    ]
                    []
                    [ styled div
                        [ property "display" "grid"
                        , property "grid-template-columns" "repeat(3, 1fr)"
                        , property "justify-content" "space-around"
                        , property "justify-items" "center"
                        , width (pct 100)
                        , maxWidth (rem 45)
                        , height (vh 100)
                        ]
                        []
                        (styled h1
                            [ UI.Styles.heading
                            , property "grid-column-start" "span 3"
                            , property "align-self" "center"
                            ]
                            []
                            [ text "Selecciona una caja" ]
                            :: (boxes |> List.map (always giftBox))
                        )
                    ]

            else
                text "TODO: Game finished message"

        BoxPrompt { box, options, attemptedOptions } ->
            text "TODO: Box prompt"

        SuccessMessage ->
            text "TODO: Success message"

        ErrorMessage boxPromptData ->
            text "TODO: Error message"


giftBox : Html msg
giftBox =
    Svg.svg
        [ SvgAttr.width "102"
        , SvgAttr.height "112"
        , SvgAttr.viewBox "0 0 102 112"
        , SvgAttr.fill "none"
        ]
        [ Svg.ellipse
            [ SvgAttr.cx "51.1074"
            , SvgAttr.cy "109.191"
            , SvgAttr.rx "50.1875"
            , SvgAttr.ry "2.75"
            , SvgAttr.fill "#C4C4C4"
            ]
            []
        , Svg.path
            [ SvgAttr.d "M84.8351 42.2004H4.93506V109.19H84.8351V42.2004Z"
            , SvgAttr.fill "#FDB827"
            ]
            []
        , Svg.path
            [ SvgAttr.d "M53.1851 42.2004H36.5751V109.19H53.1851V42.2004Z"
            , SvgAttr.fill "#AD1717"
            ]
            []
        , Svg.path
            [ SvgAttr.d "M45.49 16.5605C45.49 16.5605 38.28 -5.06953 26.81 1.11047C15.34 7.29047 15.81 27.4405 31.22 26.1305C46.63 24.8205 45.49 16.5605 45.49 16.5605Z"
            , SvgAttr.fill "#D32F2F"
            ]
            []
        , Svg.path
            [ SvgAttr.d "M46.81 16.5605C46.81 16.5605 54.03 -5.06953 65.5 1.11047C76.97 7.29047 76.5 27.4505 61.09 26.1105C45.68 24.7705 46.81 16.5605 46.81 16.5605Z"
            , SvgAttr.fill "#D32F2F"
            ]
            []
        , Svg.path
            [ SvgAttr.d "M46.15 24.2905C49.889 24.2905 52.92 21.2595 52.92 17.5205C52.92 13.7815 49.889 10.7505 46.15 10.7505C42.411 10.7505 39.38 13.7815 39.38 17.5205C39.38 21.2595 42.411 24.2905 46.15 24.2905Z"
            , SvgAttr.fill "#AD1717"
            ]
            []
        , Svg.path
            [ SvgAttr.d "M84.7 22.6704H5.07C2.26992 22.6704 0 24.9403 0 27.7404V37.1304C0 39.9305 2.26992 42.2004 5.07 42.2004H84.7C87.5001 42.2004 89.77 39.9305 89.77 37.1304V27.7404C89.77 24.9403 87.5001 22.6704 84.7 22.6704Z"
            , SvgAttr.fill "#F3703A"
            ]
            []
        , Svg.path
            [ SvgAttr.d "M53.19 22.6704H36.58V42.2004H53.19V22.6704Z"
            , SvgAttr.fill "#D32F2F"
            ]
            []
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
