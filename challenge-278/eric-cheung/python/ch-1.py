
## strShuffle = "and2 Raku3 cousins5 Perl1 are4"  ## Example 1
## strShuffle = "guest6 Python1 most4 the3 popular5 is2 language7"  ## Example 2
strShuffle = "Challenge3 The1 Weekly2"  ## Example 3

arrSplit = sorted([[int(strLoop[-1]), strLoop[:-1]] for strLoop in strShuffle.split()])

arrOrder = [strSortLoop for nSort, strSortLoop in arrSplit]

print (" ".join(arrOrder))
