module UI.Styles exposing (button, heading)

import Css exposing (..)


buttonOverlay : Style
buttonOverlay =
    batch
        [ position absolute
        , padding (px 0)
        , top (px 0)
        , left (px 0)
        , width (pct 100)
        , height (pct 100)
        , overflow hidden
        , backgroundColor currentColor
        , borderRadius inherit
        , opacity (num 0)
        , hover [ opacity (num 0.04) ]
        , focus [ opacity (num 0.08) ]
        , active [ opacity (num 0.12) ]
        ]


button : Style
button =
    batch
        [ letterSpacing (pct 2.5)
        , fontSize (em 2)
        , fontWeight (int 500)
        , fontFamilies [ "Atma" ]
        , minWidth (rem 6)
        , padding2 (rem 0.25) (rem 1)
        , backgroundColor (hex "#D9D9D9")
        , border (px 0)
        , borderRadius (px 4)
        , outline none
        , position relative
        , cursor pointer
        , property "transition-duration" "0.28s"
        , property "box-shadow" "0px 3px 1px -2px rgba(0, 0, 0, 0.2), 0px 2px 2px 0px rgba(0, 0, 0, 0.14), 0px 1px 5px 0px rgba(0, 0, 0, 0.12)"
        , hover [ property "box-shadow" "0px 2px 4px -1px rgba(0, 0, 0, 0.2), 0px 4px 5px 0px rgba(0, 0, 0, 0.14), 0px 1px 10px 0px rgba(0, 0, 0, 0.12)" ]
        , focus [ property "box-shadow" "0px 2px 4px -1px rgba(0, 0, 0, 0.2), 0px 4px 5px 0px rgba(0, 0, 0, 0.14), 0px 1px 10px 0px rgba(0, 0, 0, 0.12)" ]
        , before
            [ property "content" "\"\""
            , buttonOverlay
            ]
        ]


heading : Style
heading =
    batch
        [ fontWeight (int 500)
        , letterSpacing (pct 3.5)
        , fontSize (em 2.5)
        ]
