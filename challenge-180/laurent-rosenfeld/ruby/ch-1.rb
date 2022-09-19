for test in ["Perl Weekly Challenge", "Long Live Perl"]
    chars = test.split("")
    # with new(0), 0 becomes the default value when a key is absent
    histo = Hash.new(0)
    for char in chars
        histo[char] += 1
    end
    for i in 0..chars.length - 1
        if histo[chars[i]] == 1
            print test, ": ", i, "\n"
            break
        end
    end
end
