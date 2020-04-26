#!perl6
# Task 2 Challenge 057 Solution by kevincolyer

# Shortest Unique Prefix
# Write a script to find the shortest unique prefix for each each word in the given list. The prefixes will not necessarily be of the same length.
# 
# Sample Input
#     [ "alphabet", "book", "carpet", "cadmium", "cadeau", "alpine" ]
# Expected Output
#     [ "alph", "b", "car", "cadm", "cade", "alpi" ]


# take a word
# for each prefix 
#  check if there is a word that matches that prefix
#  if no store and move on
#  if yes loop and increase prefix size
sub shortest-prefix(@input) {
    # need to squish input?
    my @output;
    my $prev="";
    for ^@input.elems -> $i {
        my @word=@input[$i].comb;
        my $j = 0;
        # look for a word that contains the prefix
        while $j < @word.elems {
            my $prefix="";
            my $found=False;
            $prefix=@word[0..$j].join;
            @output[$i]=$prefix;
            for ^@input.elems -> $k {
                next if $i==$k;
                if @input[$k].starts-with($prefix) {
                    $found=True;
                    last;
                }
            }
            if $found==False {
                last;
            }
            $j++;
        }
        ## not found so keep looking...
    }
    return @output;
}

# Sample Input
use Test;
is shortest-prefix( ("alphabet", "book", "carpet", "cadmium", "cadeau", "alpine") ),
                    [ "alph", "b", "car", "cadm", "cade", "alpi" ],
                    "example given";
