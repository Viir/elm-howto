import Html exposing (beginnerProgram, div, button, text, audio, source)
import Html.Attributes exposing (..)

audioFileUrl = "http://dict.leo.org/media/audio/ZXOapx_FyRojukaMRHKS_w.ogg"

main =
  beginnerProgram { model = 0, view = view, update = update }

view model =
  div []
    [ audio [ controls True, autoplay True ]
        [ source [ src audioFileUrl ] [] ]
    ]

update msg model = model
