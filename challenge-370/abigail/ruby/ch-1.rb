#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line {
    |line|
    #
    # Parse input
    #
    parts = line . rstrip . split "//"
    paragraph  = parts [0]
    banned_str = parts [1]

    #
    # Extract the banned words, and store them in the banned hash
    #
    banned = {}
    banned_str . downcase . scan (/\p{L}+/) {
        |ban|
        banned [ban] = 1
    }

    #
    # Extract the words from the paragraph, if they aren't banned,
    # count them using the ok hash
    #
    ok = {}
    max = ""
    ok [max] = 0
    paragraph . downcase . scan (/\p{L}+/) {
        |word|
        if !banned [word]
            ok [word] ||= 0
            ok [word]  += 1
        end
    }

    #
    # Find the most frequently used word
    #
    ok . each {
        |word, count|
        if count > ok [max]
            max = word
        end
    }

    puts (max)
}
