import Html exposing (beginnerProgram, div, button, text, audio, source, input, table)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)

type alias Model = {
  selectedAudioSourceUrl : String,
  listPlayback : List String
}

init : Model
init =
  { selectedAudioSourceUrl = "http://dict.leo.org/media/audio/ZXOapx_FyRojukaMRHKS_w.ogg",
    listPlayback = []
  }

main =
  beginnerProgram { model = init, view = view, update = update }

type Msg =
  NewSourceUrl String |
  StartPlayback

playbackView audioFileUrl =
  audio [ controls False, autoplay True ]
    [ source [ src audioFileUrl ] [] ]

view model =
  div [] [
      div [] [
        text "configure audio parameters",
        div [ style [("margin", "10px")]] [
          text "url to audio file",
          div [] [input [ placeholder "url to audio file", onInput NewSourceUrl, value model.selectedAudioSourceUrl ] []]
        ],
        button [ onClick StartPlayback ] [ text "click to start playback" ]],
      div [] (model.listPlayback |> List.map playbackView) ]

startPlayback model =
  { model | listPlayback = [ model.listPlayback, [model.selectedAudioSourceUrl]] |> List.concat }

update : Msg -> Model -> Model
update msg model =
  case msg of
    NewSourceUrl url ->
      { model | selectedAudioSourceUrl = url}
    StartPlayback ->
      (startPlayback model)
