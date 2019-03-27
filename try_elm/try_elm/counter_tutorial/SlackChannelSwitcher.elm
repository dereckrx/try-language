module SlackChannelSwitcher exposing (..)

import Html exposing (program, Html, div, ul, li, h3, text, input)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)

-- Bootstrap libs
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid

-- MODEL: State
type alias Model =
  { channels: List String
  , selectedChannel: Int
  , query: String
  }

initModel : (Model, Cmd Action)
initModel =
  (
    { channels = ["Elm", "React.js", "Ember", "Angular 2", "Om", "OffTopic" ]
    , selectedChannel = -1
    , query = ""
    }
    , Cmd.none
  )

-- UPDATE
type Action = NoOp | Filter String | Select Int

update: Action -> Model -> (Model, Cmd Action)
update action model =
  case action of
    NoOp ->
      (model, Cmd.none)

    Filter query ->
      ({ model | query = query }, Cmd.none)

    Select index ->
      ({ model | selectedChannel = index }, Cmd.none)

-- VIEW: Render function: div [attributes] [html content]
--view: Model -> Html Action
view model =
   Grid.container []          -- Responsive fixed width container
    [ CDN.stylesheet      -- Inlined Bootstrap CSS for use with reactor
    --, navbar model        -- Interactive and responsive menu
    , mainContent model
    ]

mainContent model =
  Grid.container [ class "card-panel" ]
    [ input [ onInput Filter, class "search-box" ] [ ]
    , renderChannels <| filterChannels model.channels model.query
    ]

filterChannels channels query =
  let
    contains str1 str2 =
      String.contains (String.toLower str1) (String.toLower str2)
  in
    List.filter (contains query) channels

--filter function collection =
--  case List

--renderChannels : List String -> Html
renderChannels channels =
  let
    channelItems = List.map renderChannel channels
  in
    ul [ class "collection" ] channelItems

--renderChannel : String -> Html
renderChannel name =
  li [ class "collection-item" ] [ text <| "#" ++ name ]

-- SUBS:
subscriptions : Model -> Sub Action
subscriptions model =
    Sub.batch -- Takes a list and listens to all in one sub
        [
        ]


main : Program Never Model Action
main =
    program
        { init = initModel
        , view = view
        , update = update
        , subscriptions = subscriptions
        }