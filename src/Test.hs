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
    | hasNextRow = (themeIndex, koanIndex + 1) -- get next from same theme
    | hasNextColumn = (themeIndex + 1, 0)      -- get first from next theme
    | otherwise = error "you won!"
        where hasNextColumn = themeIndex < ((length koans) - 1)
              currentTheme = koans !! themeIndex
              hasNextRow = koanIndex < ((length currentTheme) - 1)

    -- if themeIndex < (length koans) - 1
    --                                     then ( if currentTheme
    --                                         )
    -- where currentTheme = koans !! themeIndex

