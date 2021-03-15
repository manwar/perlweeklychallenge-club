#!/usr/bin/gawk

# Challenge 005
#
# Challenge #2
# Write a program to find the sequence of characters that has the most anagrams.
#
# create a hash of all words in dictionary where key is sorted list of letters
# therefore two anagrams have the same key

function alen(a, i, k) {
    k = 0;
    for(i in a) k++;
    return k;
}

function join(array, start, end, sep,    result, i) {
    if (sep == "")
       sep = " ";
    else if (sep == SUBSEP) # magic value
       sep = "";
    result = array[start];
    for (i = start + 1; i <= end; i++)
        result = result sep array[i];
    return result;
}

function word_key(word,    i, letters, key) {
    for (i = 1; i <= length(word); i++)
        letters[i] = substr(word, i, 1);
    asort(letters);
    key = join(letters, 1, alen(letters), SUBSEP);
    return key;
}

BEGIN {
    max_anagrams = 0;
    while ((getline word < "words.txt") > 0) {
        if (length(word) >= 2) {
            if (!(word ~ /[^a-zA-Z]/)) {
                key = word_key(tolower(word));
                num_anagrams = ++anagrams[key];
                if (num_anagrams > max_anagrams)
                    max_anagrams = num_anagrams;
            }
        }
    }

    num_found = 0;
    for (key in anagrams) {
        if (anagrams[key] == max_anagrams)
            found[num_found++] = key;
    }
    asort(found);

    print "Maximum of " max_anagrams " anagrams";
    for (i in found)
        print found[i];
    exit 0;
}
