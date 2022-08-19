{-
## Wed Jan 24 2018 3:49 PM
https://www.dailydrip.com/drips/search?availability=free&order=newest&page=2&q=&topic_id=2&user_id=6304&utf8=%E2%9C%93&watched=all
-}
module Main exposing (..)

import Html exposing (program, Html, div, h3, button, text, input)
import Html.Events exposing (onClick, onInput)
import Mouse
import Keyboard
-- Bootstrap libs
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid


-- MODEL ----------------------------------------------

-- Type Alias: A "named" type, here it's just a wrapper for an Int
type alias Model =
    { value: Int
    , incClicks: Int
    , decClicks: Int
    , event: String
    , title: String
    }


-- INIT ----------------------------------------------
init : ( Model, Cmd Msg )
init = (
    Model 0 0 0 "" ""
    , Cmd.none
    )

-- MESSAGES ----------------------------------------------
-- Union type: Like an enum, or just list of types
type Msg
    = Increment
    | Decrement
    | MouseMsg Mouse.Position
    | KeyMsg Keyboard.KeyCode
    | InputText String


-- UPDATE ----------------------------------------------
update : Msg -> Model -> ( Model, Cmd Msg)
update msg model =
    case msg of
        Increment -> (
            { model |
                value = model.value + 1,
                incClicks = model.incClicks + 1 }
            , Cmd.none
            )
        Decrement -> (
            { model |
                value = model.value - 1,
                decClicks = model.decClicks + 1 }
            , Cmd.none
            )
        MouseMsg position ->
            ( { model | event = "mouse" }
            , Cmd.none
            )
        KeyMsg code ->
            ( { model | event = "key" }
            , Cmd.none
            )
        InputText title ->
            ( { model | title = title }
            , Cmd.none
            )


-- VIEW ----------------------------------------------
view : Model -> Html Msg
view model =
       --Grid.container []          -- Responsive fixed width container
       --     [ CDN.stylesheet      -- Inlined Bootstrap CSS for use with reactor
       --     , navbar model        -- Interactive and responsive menu
       --     , mainContent model
       --     ]
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (toString model.value)]
        , button [ onClick Increment ] [ text "+" ]
        , h3 [] [ text (toString model.incClicks) ]
        , h3 [] [ text (toString model.decClicks) ]
        , h3 [] [ text model.event ]
        , input [ onInput InputText ] []
        ]

-- SUBSCRIPTIONS -----------------------------------

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch -- Takes a list and listens to all in one sub
        [ Mouse.clicks MouseMsg
        , Keyboard.downs KeyMsg
        ]

--- MAIN ------------------------------------------
main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
