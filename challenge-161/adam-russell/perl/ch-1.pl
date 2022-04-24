use strict;
use warnings;
##
# An abecedarian word is a word whose letters are arranged in alphabetical order. 
# For example, “knotty” is an abecedarian word, but “knots” is not. Output or 
# return a list of all abecedarian words in the dictionary, sorted in decreasing 
# order of length.
sub abecedarian{
    sort {$b->[1] <=> $a->[1]} map {[$_, length($_)]} grep{chomp; $_ eq join("", sort {$a cmp $b} split(//, $_))} @_;
}

MAIN:{
    open(DICTIONARY, "dictionary");
    for my $abc (abecedarian(<DICTIONARY>)){
        print $abc->[0] . " length: " . $abc->[1] . "\n";
    }
    close(DICTIONARY);
}