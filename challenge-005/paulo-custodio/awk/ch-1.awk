#!/usr/bin/gawk

# Challenge 005
#
# Challenge #1
# Write a program which prints out all anagrams for a given word. For more
# information about Anagram, please check this wikipedia page.
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
    word = tolower(ARGV[1]);
    key = word_key(word);
    while ((getline word < "words.txt") > 0 ) {
        word = tolower(word);
        if (word_key(word) == key)
            print word;
    }
    exit 0;
}
