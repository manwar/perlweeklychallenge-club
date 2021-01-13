tel <- list(
  "1" = c("-", ",", "@"),
  "2" = c("A", "B", "C"),
  
  "3" = c("D", "E", "F"),
  "4" = c("G", "H", "I"),
  "5" = c("J", "K", "L"),
  "6" = c("M", "N", "O"),
  "7" = c("P", "Q", "R", "S"),
  "8" = c("T", "U", "V"),
  "9" = c("W", "X", "Y", "Z")
)

string <- c("35")
selection <- unlist(strsplit(string, NULL))

expand.grid(lapply(tel[selection], tolower))