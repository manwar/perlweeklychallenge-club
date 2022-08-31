for test in [ "Perl Weekly Challenge", "Long Live Perl" ]
    histo = Dict()
    letters = split(test, "")
    for ch in test
        histo[ch] = if (haskey(histo, ch)) histo[ch]+1 else 1 end
    end
    for i in 1:length(letters)
        if (histo[only(letters[i])] == 1)
            println(test, ": ", i-1)
            break
        end
    end
end
