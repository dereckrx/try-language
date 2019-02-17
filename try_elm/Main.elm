-- elm make Main.elm --output app.html && open app.html
module Main exposing (..)
import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


-- list
-- names = [ "Alice", "Bob", "Chuck" ]
-- Records
-- point = { x = 3, y = 4 }
-- update age in bill record
-- { bill | age = 22 }

--import Html exposing (Html, span, text)
--import Html.Attributes exposing (class)

--main : Html a
--main =
--    span [ class "welcome-message" ] [ text "Hello, World!" ]
--main : Html a
main =
  Browser.sandbox { init = 0, update = update, view = view }

type Msg = Increment | Decrement

update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1

view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (String.fromInt model) ]
    , button [ onClick Increment ] [ text "+" ]
    ]






