{-
   This app demonstrates using CSS Flexible Box ('flexbox') Layout
-}


module Main exposing (main)

import Element
import Element.Background
import Html
import Html.Attributes as HA


main : Html.Html e
main =
    view


view : Html.Html e
view =
    viewUI
        |> Element.layout
            [ Element.width Element.fill
            , Element.height Element.fill
            ]


viewUI : Element.Element e
viewUI =
    [ [ Element.text "first"
            |> Element.el
                [ Element.Background.color (Element.rgb 0.8 1 0.8)
                , Element.width (Element.fillPortion 1)
                , Element.height Element.fill
                ]
      , [ Element.text "second A"
            |> Element.el
                [ Element.Background.color (Element.rgb 1 0.8 0.8)
                , Element.height Element.fill
                ]
        , Element.text "second B"
            |> Element.el
                [ Element.Background.color (Element.rgb 1 0.8 0.8)
                , Element.height Element.fill
                ]
        , Element.text "second C"
            |> Element.el
                [ Element.Background.color (Element.rgb 1 0.8 0.8)
                , Element.height Element.fill
                ]
        ]
            |> Element.row
                [ Element.spaceEvenly
                , Element.width (Element.fillPortion 2)
                , Element.height Element.fill
                ]
      ]
        |> Element.row
            [ Element.width Element.fill
            , Element.height (Element.fillPortion 3)
            ]
    , [ Element.text "third"
            |> Element.el
                [ Element.Background.color (Element.rgb 0.8 1 1)
                , Element.centerX
                , Element.centerY
                , Element.padding 10
                ]
            |> Element.el
                [ Element.width (Element.fillPortion 3)
                , Element.height Element.fill
                ]
      , Element.text "fourth"
            |> Element.el
                [ Element.Background.color (Element.rgb 1 1 0.8)
                , Element.width (Element.fillPortion 2)
                , Element.height Element.fill
                ]
      , Element.text "fifth"
            |> Element.el
                [ Element.Background.color (Element.rgb 1 0.8 1)
                , Element.width (Element.fillPortion 1)
                , Element.height Element.fill
                ]
      ]
        |> Element.row
            [ Element.width Element.fill
            , Element.height (Element.fillPortion 2)
            ]
    ]
        |> Element.column
            [ Element.width Element.fill
            , Element.height Element.fill
            ]
