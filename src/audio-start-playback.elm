-- This code file demonstrates how to control starting playback of audio in the update function of the elm program.
-- Source URL for the Audio file and playback volume can be configured from the UI.
-- Since its pure elm and does not rely on ports or native, it also works on http://elm-lang.org/try (tested with chrome and edge).

import Html exposing (beginnerProgram, div, button, text, audio, source, input, table)
import Html.Attributes exposing (..)
import Html.Attributes as HA
import Html.Events exposing (onClick, onInput)
import Json.Encode

type alias PlaybackParams = {
  sourceUrl : String,
  volume : Float
}

type alias Model = {
  selectedPlaybackParams : PlaybackParams,
  listPlayback : List PlaybackParams
}

type Msg =
  SelectAudioSourceUrl String |
  SelectPlaybackVolume String |
  StartPlayback

init : Model
init =
  { selectedPlaybackParams =
    {
      sourceUrl = "http://dict.leo.org/media/audio/ZXOapx_FyRojukaMRHKS_w.mp3",
      volume = 0.7
    },
    listPlayback = []
  }

main =
  beginnerProgram { model = init, view = view, update = update }

playbackView playbackParams =
  audio [ controls False, autoplay True, property "volume" (Json.Encode.string (toString playbackParams.volume)) ]
    [ source [ src playbackParams.sourceUrl ] [] ]

view : Model -> Html.Html Msg
view model =
  let
    selectedPlaybackParams = model.selectedPlaybackParams
    selectedSourceUrl = selectedPlaybackParams.sourceUrl
    selectedPlaybackVolume = selectedPlaybackParams.volume
  in
    div [] [
        div [] [
          text "configure audio parameters",
          div [ style [("margin", "10px")]] [
            div [] [text "url to audio file"],
            div [] [input [ placeholder "url to audio file", onInput SelectAudioSourceUrl, value selectedSourceUrl ] []],
            div [] [text "-"],
            div [] [text "playback volume"],
            div [] [input [
              type_ "range" , HA.min "0" , HA.max "100", value <| toString (selectedPlaybackVolume * 100),
              onInput SelectPlaybackVolume] [], text <| (((toString (selectedPlaybackVolume * 100))) ++ "%")]
          ],
          button [ onClick StartPlayback ] [ text "click to start playback" ]],
          div [] [text "-"],
          div [] [text (toString (model.listPlayback |> List.length) ++ " playbacks started")],
          div [] (model.listPlayback |> List.map playbackView) ]

startPlayback : Model -> Model
startPlayback model =
  { model | listPlayback = [ model.listPlayback, [model.selectedPlaybackParams]] |> List.concat }

updatePlaybackParams : Msg -> PlaybackParams -> PlaybackParams
updatePlaybackParams msg playbackParams =
  case msg of
    SelectAudioSourceUrl url ->
      { playbackParams | sourceUrl = url}
    SelectPlaybackVolume volumeString ->
      { playbackParams | volume = (String.toFloat volumeString |> Result.withDefault 40) * 0.01 }
    _ -> playbackParams

update : Msg -> Model -> Model
update msg model =
  let withPlaybackParams = { model | selectedPlaybackParams = updatePlaybackParams msg model.selectedPlaybackParams }
  in
    case msg of
      StartPlayback ->
        (startPlayback withPlaybackParams)
      _ -> withPlaybackParams
