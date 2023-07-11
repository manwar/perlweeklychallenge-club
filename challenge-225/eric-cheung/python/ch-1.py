
## arrWordList = ["Perl and Raku belong to the same family.", "I love Perl.", "The Perl and Raku Conference."]  ## Example 1
arrWordList = ["The Weekly Challenge.", "Python is the most popular guest language.", "Team PWC has over 300 members."]  ## Example 2

arrWordLen = [len(wordLoop.split()) for wordLoop in arrWordList]
nMaxWordLen = max(arrWordLen)

print (nMaxWordLen)
