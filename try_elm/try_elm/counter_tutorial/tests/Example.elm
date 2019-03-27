module Example exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)


suite : Test
suite =
    todo "Implement our first test. See http://package.elm-lang.org/packages/elm-community/elm-test/latest for how to do this!"


all : Test
all =
    describe "Sample Test Suite"
        [ describe "Unit test examples"
            [ test "Addition" <|
                \() ->
                    Expect.equal (3 + 7) 10
            , test "String.left" <|
                \() ->
                    Expect.equal "a" (String.left 1 "abcdefg")
            , test "This test should fail - you should remove it" <|
                \() ->
                    Expect.fail "Failed as expected!"
            ]
        ]