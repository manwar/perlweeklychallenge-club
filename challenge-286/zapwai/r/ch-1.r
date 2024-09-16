lines <- readLines("ch-1.r")
words <- c()
for (l in lines) {
    word = strsplit(l, " ")[[1]]
    words <- append(words, word)
}
num <- sample(1:length(words), 1)
cat(words[num],"\n")
