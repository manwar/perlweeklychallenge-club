#!/usr/bin/gawk

# Challenge 004
#
# Challenge #2
# You are given a file containing a list of words (case insensitive 1 word per
# line) and a list of letters. Print each word from the file that can be made
# using only letters from the list. You can use each letter only once (though
# there can be duplicates and you can use each of them once), you don't have to
# use all the letters.
# (Disclaimer: The challenge was proposed by Scimon Proctor)

function matches(word, letters,    i, j, ch) {
    for (i = 1; i <= length(letters); i++) {
        ch = substr(letters, i, 1);
        j = index(word, ch);
        if (j > 0)
            word = substr(word, 1, j-1) substr(word, j+1)
        if (word == "") return 1;
    }
    return 0;
}

BEGIN {
    letters = tolower(ARGV[1]);
    while ((getline word < "words.txt") > 0 ) {
        if (length(word) >= 2 &&
            !(word ~ /[^a-zA-Z]/) &&
            matches(word, letters))
            print word;
    }
    exit 0;
}
