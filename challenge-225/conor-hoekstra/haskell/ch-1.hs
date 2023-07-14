maxWords = maximum . map (length . words)                        -- Solution 1
maxWords = (1+) . maximum . map (length . filter (==' '))        -- Solution 2
maxWords = (1+) . maximum . map (sum . map (fromEnum . (==' '))) -- Solution 3
