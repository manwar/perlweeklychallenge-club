for test in [ "Perl Weekly Challenge", "Long Live Perl" ]
    histo = []
    for i = 1 to len(test)
        histo[test[i]] = 0 + histo[test[i]] + 1
    next
    for i = 1 to len(test)
        if histo[test[i]] = 1
            see test + ": " + (i-1) + nl
            exit
        ok
    next
next
