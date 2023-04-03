#!/usr/bin/python3

# Challenge 014
#
# Challenge #2
# Using only the official postal (2-letter) abbreviations for the 50 U.S.
# states, write a script to find the longest English word you can spell? Here
# is the list of U.S. states abbreviations as per wikipedia page. This challenge
# was proposed by team member Neil Bowers.
#
# For example,
# Pennsylvania + Connecticut = PACT
# Wisconsin + North Dakota = WIND
# Maine + Alabama = MEAL
# California + Louisiana + Massachusetts + Rhode Island = Calamari

import re
import sys

us_states = {
    'AL':'Alabama',
    'AK':'Alaska',
    'AZ':'Arizona',
    'AR':'Arkansas',
    'CA':'California',
    'CO':'Colorado',
    'CT':'Connecticut',
    'DE':'Delaware',
    'FL':'Florida',
    'GA':'Georgia',
    'HI':'Hawaii',
    'ID':'Idaho',
    'IL':'Illinois',
    'IN':'Indiana',
    'IA':'Iowa',
    'KS':'Kansas',
    'KY':'Kentucky',
    'LA':'Louisiana',
    'ME':'Maine',
    'MD':'Maryland',
    'MA':'Massachusetts',
    'MI':'Michigan',
    'MN':'Minnesota',
    'MS':'Mississippi',
    'MO':'Missouri',
    'MT':'Montana',
    'NE':'Nebraska',
    'NV':'Nevada',
    'NH':'New Hampshire',
    'NJ':'New Jersey',
    'NM':'New Mexico',
    'NY':'New York',
    'NC':'North Carolina',
    'ND':'North Dakota',
    'OH':'Ohio',
    'OK':'Oklahoma',
    'OR':'Oregon',
    'PA':'Pennsylvania',
    'RI':'Rhode Island',
    'SC':'South Carolina',
    'SD':'South Dakota',
    'TN':'Tennessee',
    'TX':'Texas',
    'UT':'Utah',
    'VT':'Vermont',
    'VA':'Virginia',
    'WA':'Washington',
    'WV':'West Virginia',
    'WI':'Wisconsin',
    'WY':'Wyoming',
}

def read_file(filename):
    with open(filename) as f:
        return f.readlines()

def read_words(lines):
    words = []
    for line in lines:
        word = line.strip()
        if not re.search(r"\W", word):
            words.append(word)
    return words

def word_regexp():
    state_abbr = []
    for state in us_states:
        state_abbr.append(state)
    return r"(?i:^("+"|".join(state_abbr)+r")+$)"

def words_like_states(words):
    matched = []
    regexp = word_regexp()
    for word in words:
        if re.match(regexp, word):
            matched.append(word)
    return matched

def longest_words(words):
    longest = []
    size = 0
    for word in words:
        if len(word) > size:
            longest = [word]
            size = len(word)
        elif len(word) == size:
            longest.append(word)
    return longest

def word_to_states(word):
    states = []
    for i in range(0, len(word), 2):
        cc = word[i:i+2].upper()
        states.append(us_states[cc])
    return " + ".join(states)

words = longest_words(words_like_states(read_words(read_file(sys.argv[1]))))
for word in words:
    print(word+" = "+word_to_states(word))
