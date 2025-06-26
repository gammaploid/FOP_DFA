import System.IO (hFlush, stdout) 

data State = S0 | S1 | S2 | S3 deriving (Show, Eq)   
type Symbol = Char

transition :: State -> Symbol -> State -- signature: takes in state (from output State, as input), proccess symbol, outputs state
transition S0 '0' = S1
transition S0 '1' = S2
--
transition S1 '0' = S1
transition S1 '1' = S2
--
transition S2 '0' = S2
transition S2 '1' = S3
--
transition s _ = s

-- Recursive DFA function runner
runDFA :: State -> [Symbol] -> State  -- signature: takes in state (fron output State, as input), proccess symbol [list] one symbol at a time, output final state after all symbols consumed
runDFA state [] = state 
-- 1st half is pattern matching x is head of list, xs is tail of list
-- 2nd half is recursive call, calling runDFA (transition state x) xs, swallowing in transition :: State -> Symbol , 
runDFA state (x:xs) = runDFA (transition state x) xs


isAccepted :: State -> Bool
isAccepted S2 = True
isAccepted _  = False


main :: IO ()
main = do

    putStrLn "Welcome to the machine. You have entered a Deterministic Finite Automaton (DFA) -- Haskell Edition \n"
    putStrLn "============================================\n"
    putStrLn "•Enter a binary string that has only one occurence of '1' |  Example: 1, 01, 00010, etc: \n "

    input <- getLine

    putStrLn $ "You entered string: " ++ input
    putStrLn "\nProcessing transitions..."
    putStrLn "============================================\n"

    let finalState = runDFA S0 input

    if isAccepted finalState

        then putStrLn ("Final state: \"" ++  show finalState ++ "\" for string: \"" ++ input ++ "\"\nAccepted!" ++" → One occurence of [1] only\n" ++
            "============================================\n" ++
            "\n\n    (｡◕‿‿◕｡) \n\n")

        else putStrLn $ "\n********************************************\n"
        ++ "Final state: \"" ++  show finalState ++ "\" for string: \"" ++ input ++ "\"\nRejected!" ++" → More than one [1] or no [1's] yet\n"
        ++ "********************************************\n\n\n    \n\n"
        ++ " _________        .---'''''      '''''---.              \n"
        ++ ":______.-':      :  .--------------.  :             \n"
        ++ "| ______  |      | :                : |             \n"
        ++ "|:______B:|      | |  Little Error: | |             \n"
        ++ "|:______B:|      | |  ୧༼ಠ益ಠ༽︻╦╤─  | |             \n"
        ++ "|:______B:|      | |                | |             \n"
        ++ "|         |      | |  DFA doess not | |             \n"
        ++ "|:_____:  |      | |   not like     | |             \n"
        ++ "|    ==   |      : :    your string : :             \n"
        ++ "|       O |      :  '--------------'  :             \n"
        ++ "|       o |      :'---...______...---'              \n"
        ++ "|       o |-._.-i___/'             \\._              \n"
        ++ "'-.____o_|   '-.   '-...______...-'  `-._          \n"
        ++ ":_________:      `.____________________   `-.___.-. \n"
        ++ "                 .'.eeeeeeeeeeeeeeeeee.'.      :___:\n"
        ++ "    fsc        .'.eeeeeeeeeeeeeeeeeeeeee.'.         \n"
        ++ "              :____________________________:"



    putStr "\nRun again? (y/Y | any key to exit): "
    -- flush stdout to ensure the prompt is displayed immediately
    hFlush stdout
    again <- getLine
    if again == "y" || again == "Y"
        then main
        else putStrLn "Bye ~~"