type Koan = [Char]


logicalKoans :: [Koan]
logicalKoans = [
        "&&", "||"
    ]

arithmeticKoans :: [Koan]
arithmeticKoans = [
        "+", "-", "/"
    ]

koans :: [[Koan]]
koans = [
        logicalKoans,
        arithmeticKoans
    ]


getNextKoan :: (Int, Int) -> (Int, Int)
getNextKoan (themeIndex, koanIndex)
    | hasNextRow    = (themeIndex, koanIndex + 1) -- get next from same theme
    | hasNextColumn = (themeIndex + 1, 0)      -- get first from next theme
    | otherwise     = error "you won!"
        where hasNextColumn = themeIndex < ((length koans) - 1)
              currentTheme  = koans !! themeIndex
              hasNextRow    = koanIndex < ((length currentTheme) - 1)

getPreviousKoan :: (Int, Int) -> Maybe (Int, Int)
getPreviousKoan (themeIndex, koanIndex)
    | hasPreviousRow    = Just (themeIndex, koanIndex - 1)
    | haspreviousColumn = Just (themeIndex - 1, (length previousColumn) - 1)
    | otherwise         = Nothing
        where hasPreviousRow    = koanIndex > 0
              haspreviousColumn = themeIndex > 0
              previousColumn    = koans !! (themeIndex - 1)

