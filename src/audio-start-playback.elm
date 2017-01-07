import Html exposing (beginnerProgram, div, button, text, audio, source)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

audioFileUrl = "http://dict.leo.org/media/audio/ZXOapx_FyRojukaMRHKS_w.ogg"

type alias Model = List String

main =
  beginnerProgram { model = [], view = view, update = update }

type Msg = StartPlayback

playbackView audioFileUrl =
  audio [ controls False, autoplay True ]
    [ source [ src audioFileUrl ] [] ]

view model =
  div []
    [ div []
      [ button [ onClick StartPlayback ] [ text "click to play audio" ]],
      div [] (model |> List.map playbackView) ]

update msg model =
  case msg of
    StartPlayback -> model |> List.append [audioFileUrl]
