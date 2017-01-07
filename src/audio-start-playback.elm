import Html exposing (beginnerProgram, div, button, text, audio, source)
import Html.Attributes exposing (..)

audioFileUrl = "http://dict.leo.org/media/audio/ZXOapx_FyRojukaMRHKS_w.ogg"

main =
  beginnerProgram { model = 0, view = view, update = update }

playbackView audioFileUrl =
  audio [ controls True, autoplay True ]
    [ source [ src audioFileUrl ] [] ]

view model =
  div []
    [ playbackView audioFileUrl ]

update msg model = model
