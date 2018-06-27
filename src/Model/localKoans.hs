module Model.LocalKoans 
 (
    localKoans
 ) where

import Model.Koan (Koan(..))

logical :: [Koan]
logical = [
    Koan { theme="Logical Operators", intro="Truth Sould Always Be Capitalized", code="True == #", answer="True" },
    Koan { theme="Logical Operators", intro="Falseness Sould As Well", code="# /= True", answer="False" },
    Koan { theme="Logical Operators", intro="One who is not in truth can only be in falsehood", code="not # == False", answer="True" },
    Koan { theme="Logical Operators", intro="One cannot be right and wrong at the same time", code="True && False == #", answer="False" },
    Koan { theme="Logical Operators", intro="Truth always prevails prevails given the chance", code="True || False == #", answer="True" }
  ]

arithmetic :: [Koan]
arithmetic = [
    Koan { theme="Arithmetic Operators", intro="Together we are more", code="1 # 1 == 2", answer="+" },
    Koan { theme="Arithmetic Operators", intro="Absence is leaves space for nothingness", code="1 # 1 == 0", answer="-" },
    Koan { theme="Arithmetic Operators", intro="Sharing is caring", code="10 / 2 == #", answer="5" },
    Koan { theme="Arithmetic Operators", intro="Multiply what matters to you", code="10 * 2 == #", answer="20" }
  ]


lists :: [Koan]
lists = [
    Koan { theme="Lists", intro="Keep close what belongs together", code="[\"a\", \"e\", \"i\", \"o\", \"u\"#", answer="]" },
    Koan { theme="Lists", intro="There are different ways to achieve the same result", code="[\"a\", \"b\", \"c\"] == a : b # c : []", answer=":" },
    Koan { theme="Lists", intro="Some things are not what they seem", code="['a', 'b'] == \"a#\"", answer="b" },
    Koan { theme="Lists", intro="Keep your head on top of things", code="head [1, 2, 3] == #", answer="1" },
    Koan { theme="Lists", intro="Do not keep your tail between your legs", code="# [1, 2, 3] == [2, 3]", answer="tail" },
    Koan { theme="Lists", intro="Always measure your options well", code="length [True, False] == #", answer="2" },
    Koan { theme="Lists", intro="Sometimes you might question if you belong", code="3 `elem` [1, 2, 3] == #", answer="True" },
    Koan { theme="Lists", intro="But answers are always in range", code="[1, 2, 3, 4, 5] == [1..#]", answer="5" },
    Koan { theme="Lists", intro="Comprehension is key for double understanding", code="[x*# | x <- [1..3]] == [2, 4, 6]", answer="2" }
  ]

touples :: [Koan]
touples = [
    Koan { theme="Tuples", intro="Sometimes listing things are not the answer", code="(\"two\", 2, True) == (\"two\"#)", answer=", 2, True" },
    Koan { theme="Tuples", intro="Sometimes the first thing that comes to mind is right", code="fst (1, 2) == #", answer="1" },
    Koan { theme="Tuples", intro="Sometimes it is the second", code="snd (1, #) == 2", answer="2" }
  ]

types :: [Koan]
types = [
    Koan { theme="Types", intro="Learning is Integral to development of self", code="(1 :: Int) == #", answer="1" },
    Koan { theme="Types", intro="Double the effort only when necessary", code="(3.1514 :: #) == 3.1514", answer="Double" },
    Koan { theme="Types", intro="Don't String things along", code="(\"along\" :: #) == \"along\"", answer="String" },
    Koan { theme="Types", intro="Who says what is True or False?", code="(True # Bool) == True", answer="::" }
  ]

functions :: [Koan]
functions = [
    Koan { theme="Functions", intro="Define what things are for yourself", code="doubleMe :# Int -> Int", answer=":" },
    Koan { theme="Functions", intro="Only you should decide what to do", code="doubleMe x = 2 # x", answer="*" },
    Koan { theme="Functions", intro="What you build is yours to use", code="doubleMe # == 20", answer="10" }
  ]
    
higherOrder :: [Koan]
higherOrder = [
    Koan { theme="Higher Order Functions", intro="Equal treatment for all", code="map (+#) [1, 2, 3] == [2, 3, 4]", answer="1" },
    Koan { theme="Higher Order Functions", intro="Raise your standards", code="filter (>2) [1, 2, 3] == [#]", answer="3" },
    Koan { theme="Higher Order Functions", intro="Reduce your worries", code="foldl (+) 0 [1, 2, #] == 6", answer="3" }
  ]

localKoans :: [[Koan]]
localKoans = [
    logical,
    arithmetic,
    lists,
    touples,
    types,
    functions,
    higherOrder
  ]
