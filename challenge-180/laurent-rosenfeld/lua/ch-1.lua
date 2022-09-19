for _, test in pairs{"Perl Weekly Challenge", "Long Live Perl"} do
    local histo = {} -- letter histotogram
    for ch in string.gmatch(test, ".") do
        -- histo[ch] = histo[ch] == nil and 1 or histo[ch] + 1
        histo[ch] = (histo[ch] or 0) + 1
    end
    i = 0
    for ch in string.gmatch(test, ".") do
        if histo[ch] == 1 then
            print(test, ": ", i)
            break
        end
        i = i + 1
    end
end
