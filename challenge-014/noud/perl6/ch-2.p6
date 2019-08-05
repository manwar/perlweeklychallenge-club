# Challenge #2
#
# Using only the official postal (2-letter) abbreviations for the 50 U.S.
# states, write a script to find the longest English word you can spell? Here
# is the list of U.S. states abbreviations as per wikipedia page. This
# challenge was proposed by team member Neil Bowers.
#
# For example,
# Pennsylvania + Connecticut = PACT
# Wisconsin + North Dakota = WIND
# Maine + Alabama = MEAL
# California + Louisiana + Massachusetts + Rhode Island = Calamari

my @usps = ('al', 'ak', 'az', 'ar', 'ca', 'co', 'ct', 'de', 'dc', 'fl', 'ga',
    'hi', 'id', 'il', 'in', 'ia', 'ks', 'ky', 'la', 'me', 'md', 'ma', 'mi',
    'mn', 'ms', 'mo', 'mt', 'ne', 'nv', 'nh', 'ny', 'nc', 'oh', 'ok', 'or',
    'pa', 'ri', 'sc', 'sd', 'tn', 'tx', 'ut', 'vt', 'va', 'wa', 'wv', 'wi',
    'wy');


# Downloaded a bunch of English words from the internet.
my @words = 'words.txt'.IO.words;

sub usps_word($s) {
    # Returns True if argument can be constructed with USPS postal codes.
    return ($s.encode.elems % 2 == 0)
        && (($s.encode.elems == 0)
            || (@usps.first($s.comb[^2].join)
                && usps_word($s.comb[2..*].join))
            || False);
}

# Print largest word that can be created with USPS postal codes. Depending on
# the list of search words, the largest word I could find is "cacogalactia".
say @words.grep({usps_word($_.lc)}).map({($_.encode.elems, $_)}).sort[*-1][1];
