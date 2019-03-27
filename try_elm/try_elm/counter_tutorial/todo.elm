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
    { todos: List
    }

type alias Todo =
    { title : String
    , text: String
    , completed: Boolean
    }

type alias TodoId = Int


-- INIT ----------------------------------------------
init : ( Model, Cmd Msg )
init = (
    Model []
    , Cmd.none
    )

-- MESSAGES ----------------------------------------------
-- Union type: Like an enum, or just list of types
type Action
    = AddTodo Todo
    | RemoveTodo TodoId
    | CompleteTodo TodoId


-- UPDATE ----------------------------------------------
update : Action -> Model -> ( Model, Cmd Msg)
update action model =
    case msg of
        AddTodo todo -> (
            { model |
                value = model.value + 1,
                incClicks = model.incClicks + 1 }
            , Cmd.none
            )
        RemoveTodo id -> (
            { model | todos = removeTodo model.todos id
            , Cmd.none
            )
        CompleteTodo id ->
            ( { model | todos = completeTodo model.todos id
            , Cmd.none
            )

removeTodo items id = filter (\i -> i.id != id) items
completeTodo items id =
    items
    |> List.filter (\i -> i.id == id)
    |> List.map (\i -> { i | completed = True} )
    |> List.head

-- VIEW ----------------------------------------------
view : Model -> Html Msg
view model =
   Grid.container []          -- Responsive fixed width container
        [ CDN.stylesheet      -- Inlined Bootstrap CSS for use with reactor
        , navbar model        -- Interactive and responsive menu
        , mainContent model
        ]
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
