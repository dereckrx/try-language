{-
----------------------------------------
Haskell 

Book
http://learnyouahaskell.com/starting-out
------------------------------------------
-}



{-
	
# Install
brew install ghc cabal-install haskell-stack

## Curl (homebrew has problems I guess)
curl https://get-ghcup.haskell.org -sSf | sh


Haskell:
* Glasgow Haskell Compiler (GHC): ghc, ghcup
* Cabal build tool: cabal

/Users/dereckrx/.ghcup/bin

source /Users/dereckrx/.ghcup/env

curl -sSL https://get.haskellstack.org/ | sh
* Adds: /usr/local/bin/stack
-}

{-
string = "hello"
string2 = "world"

greeting = string ++ " " ++ string2

add x y = x + y

-- List
x = [1,2,3]
-- cons equivlent
y = 1 : 2 : 3 : []

empty = []
-}

{-
-- ghc -o hello hello.hs
main :: IO ()
main = putStrLn "Hello, World!"
-}

reverseLines :: String -> String
reverseLines input = unlines (map reverse (lines input))

echo :: String -> String
echo input = input ++ "a"

main = interact echo

-- readFile, writeFile, app