module Playground exposing (..)

import Html exposing (div, ul, li, text)
import Dict

todos =
  [ { id = 1, completed = False }
  , { id = 2, completed = False }
  ]

result id = List.filter (\i -> i.id /= id) todos

compResult id items =
    items
      |> List.filter (\i -> i.id == id)
      |> List.map (\i -> { i | completed = True} )
      |> List.head

updateItem id items =
  items
    |> List.filter (\i -> i.x == id)
    |> List.map (\i -> if i.x == 2 then {i | x = -1 } else i)

--main =
--  div []
--    [ ul []
--      [ li [] [ text <| toString <| compResult 1 todos ]
--      , li [] [ text <| toString todos ]
--      ]
--    ]
type alias Record = { x : Int }

maybeCase : (Record -> Record) -> Maybe Record -> Maybe Record
maybeCase func maybe =
  case maybe of
    Just i -> Just <| func i --{ i | x = -1 }
    Nothing -> Nothing

replace key dict =
  let
    item = Dict.get key dict
  in
    case item of
      Just i -> Dict.insert key { i | x = -1 } dict
      Nothing -> dict

replace2 key dict =
  Dict.update key (maybeCase(\i -> { i | x = -1 })) dict

main =
  Dict.empty
    |> Dict.insert 1 {x = 1}
    |> Dict.insert 2 {x = 2}
    |> Dict.insert 3 {x = 3}
  |> replace2 1
  |> toString
  |> text

