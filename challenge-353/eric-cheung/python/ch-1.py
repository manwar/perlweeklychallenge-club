
## arrSentences = ["Hello world", "This is a test", "Perl is great"]  ## Example 1
## arrSentences = ["Single"]  ## Example 2
## arrSentences = ["Short", "This sentence has six words in total", "A B C", "Just four words here"]  ## Example 3
## arrSentences = ["One", "Two parts", "Three part phrase", ""]  ## Example 4
arrSentences = ["The quick brown fox jumps over the lazy dog", "A", "She sells seashells by the seashore", "To be or not to be that is the question"]  ## Example 5

arrLenSentence = [len(strLoop.split(" ")) for strLoop in arrSentences]

print (max(arrLenSentence))
