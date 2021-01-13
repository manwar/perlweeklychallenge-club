library(runner)
size <- 3
minis <- runner(c(1, 5, 0, 2, 9, 3, 7, 6, 4, 8), k = size, f = min)

(minis <- minis[size:length(minis)]) # 0 0 0 2 3 3 4 4
rm(size, minis)
