#!/usr/bin/env perl

###########################################################################
# script name: ch-2.pl                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-057/         #
#                                                                         #
# Shortest Unique Prefix                                                  #
# Write a script to find the shortest unique prefix for each each word    #
# in the given list. The prefixes will not necessarily be of the same     #
# length.                                                                 #
#                                                                         #
# Sample Input                                                            #
# [ "alphabet", "book", "carpet", "cadmium", "cadeau", "alpine" ]         #
# Expected Output                                                         #
# [ "alph", "b", "car", "cadm", "cade", "alpi" ]                          #
#                                                                         #
###########################################################################

use strict;
use warnings;

sub charsMatch {
    my $string1 = $_[0];
    my $string2 = $_[1];
    my $count   = 0;
    my $limit   = 0;
    my @s1 = split m{}, $string1;
    my @s2 = split m{}, $string2;

    if ( @s2 > @s1 ) {
        $limit = $#s1;
    } else {
        $limit = $#s2;
    }

  LETTER_BY_LETTER:
    for (my $i = 0; $i <= $limit; ++$i) {
        if ( $s1[$i] eq $s2[$i] ) {
            ++$count;
        } else {
            last LETTER_BY_LETTER;
        }
    }

    ++$count if $count + 1 <= $limit;
    return $count
}

my @unSorted = qw{ alphabet book carpet cadmium cadeau alpine };
my %prefix = ();

my @sorted = sort @unSorted;
my $diff = 0;

for (my $i = 0; $i <= $#sorted; ++$i) {
    if ( $i == 0 ) {
       $diff = charsMatch $sorted[0], $sorted[1];
    } elsif ($i == $#sorted ) {
       $diff =  charsMatch( $sorted[ $#sorted - 1 ] , $sorted[ $#sorted ] );
    } else {
        my $before = charsMatch( $sorted[$i-1] , $sorted[$i]   );
        my $after  = charsMatch( $sorted[$i]   , $sorted[$i+1] );
        $diff = $before > $after ? $before : $after;
    }
    $prefix{ $sorted[$i] } = substr $sorted[$i], 0, $diff;
}

print "[ ";
for ( my $j = 0; $j <=  $#unSorted; ++$j ) {
    print ", " if $j > 0;
    print '"' . $prefix{ $unSorted[$j] } . '"';
}
print " ]\n";

__END__
output:

[ "alph", "b", "car", "cadm", "cade", "alpi" ]
