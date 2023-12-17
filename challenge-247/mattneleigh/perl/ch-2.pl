#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    # Given cases
    "abcdbca",
    "cdeabeabfcdfabgcd",

    # Additional test cases
    "",
    "xmzycqpn",
    "abcdefcdefxyabcdefxyxy"
);

print("\n");
foreach my $string (@strings){
    my $rval = most_frequent_consecutive_pair($string);

    printf(
        "Input: \$s = '%s'\nOutput: %s\n\n",
        $string,
        defined($rval) ? "'" . $rval . "'" : "No suitable pair found"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string of lower-case letters (a-z) determine the most frequently seen
# consecutive pair of letters (e.g. "ab", "wx", et al.) within the string; if
# two or more pairs are tied for greatest frequency, the one that is
# lexicographically smallest is returned
# Takes one argument:
# * The string to examine (e.g. "cdeabeabfcdfabgcd")
# Returns on success:
# * The pair of consecutive letters that was seen most frequently; if two or
#   more pairs are tied for maxium frequency count, this will be the
#   lexicographically smallest of these (e.g. "ab")
# Returns on error:
# * undef if no consecutive pairs were found in the string
################################################################################
sub most_frequent_consecutive_pair{
    my @chars = split('', lc(shift()));

    my %pairs = ();
    my $max = 0;

    # Loop from 1 to the highest index in
    # @chars
    for my $i (1 .. $#chars){
        if((ord($chars[$i - 1]) + 1) == ord($chars[$i])){
            # Characters $i - 1 and $i are
            # consecutive...
            my $pair = $chars[$i - 1] . $chars[$i];

            if($pairs{$pair}){
                # This pair has been seen already;
                # increment its count and update the max
                # count if this count is larger
                $pairs{$pair}++;
                $max++
                    if($pairs{$pair} > $max);
            } else{
                # This pair has not been seen before;
                # start its count and update the max
                # count if it hasn't been set yet
                $pairs{$pair} = 1;
                $max = 1
                    unless($max);
            }
        }
    }

    return(
        # 3: Take the first (lexicographically
        # smallest) pair from the list
        (
            # 2: Sort the list of pairs in ascending
            # lexicographical order
            sort(
                # 1: Make a list of pairs that have the
                # max frequency count
                map(
                    $pairs{$_} == $max ? $_ : (),
                    keys(%pairs)
                )
            )
        )[0]
    );

}



