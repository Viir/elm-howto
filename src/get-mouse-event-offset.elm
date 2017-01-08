-- This code file demonstrates how to obtain the 'offset' portion of a mouse event and how to disable hittesting on svg elements.

import Html exposing (beginnerProgram, div, button, text, audio, source, input, table)
import Html.Events
import Svg exposing (Svg)
import Svg.Attributes exposing (..)
import Mouse
import Json.Decode as Decode exposing (field)


type alias Model = {
    mouseOffset : Mouse.Position
}

type Msg =
  MouseEventOffset Mouse.Position

main =
  beginnerProgram { model = init, view = view, update = update }

init = {mouseOffset = {x = 0, y = 0}}

update : Msg -> Model -> Model
update msg model =
    case msg of
    MouseEventOffset offset -> { model | mouseOffset = offset }

offsetPosition : Decode.Decoder Mouse.Position
offsetPosition =
    Decode.map2 Mouse.Position (field "offsetX" Decode.int) (field "offsetY" Decode.int)

eventOffsetToMessageAttribute =
    Html.Events.on "mousemove" (Decode.map MouseEventOffset offsetPosition)

view : Model -> Html.Html Msg
view model = div [][
  Svg.svg [ width "400"
        , height "400"
        , fill "white"
        ][
            Svg.g [ transform "translate(10, 40)"] [
                Svg.rect [ x "0", y "0", width "300", height "300", fill "grey" , opacity "0.5", eventOffsetToMessageAttribute] [],
                Svg.circle [ cx (toString model.mouseOffset.x), cy (toString model.mouseOffset.y), r "10", fill "blue", opacity "0.5", pointerEvents "none"] []
            ]
        ],
  div [][
      text ("mouse offset: " ++ (toString model.mouseOffset ))
      ]
  ]

