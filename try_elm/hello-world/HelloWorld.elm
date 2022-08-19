-- IntelliJ Setup:
-- * Depends on an elm.json to pull in dependencies
-- * elm embedding in html is not working

module HelloWorld exposing (..)
import Platform exposing (worker)
import Debug exposing (log)

-- Runner
-- Program flags model msg
runner : a -> Program () () ()
runner = \a -> worker
  { init = \flags -> ( (), Cmd.none )
  , update = \() -> \() -> ( (), Cmd.none )
  , subscriptions = \() -> Sub.none
  }

main : Program () () ()
main =
  runner run

--run =
--  let
--    a = print "Hello World!!!"
--    b = expect 1 toEqual 1
--    c = expect 1 toEqual 2
--  in
--    ()


suite a = ()

run =
  [ it "passes if equal" <| \() ->
      expect 1 toEqual 1

  , it "fails if not equal" <| \() ->
      expect 1 toEqual 2
  ]

print : String -> String
print message = log message ""

-- define function
isNegative n = n < 0

-- anonymous function
anonFn = \n -> n < 0

toEqual result expected =
  if result == expected then
    print "Pass"
  else
    print <|
      "Fail: expected " ++
      (String.fromInt result) ++
      " to equal " ++
      (String.fromInt expected)

expect result tester expected =
  tester result expected

it name test =
  let
    a = test()
  in
    suite

