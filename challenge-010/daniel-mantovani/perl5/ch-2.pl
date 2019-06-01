# Write a script to find Jaro-Winkler distance between two strings.
# For more information check wikipedia page.

use strict;
use warnings;
use v5.10;

# we start by reading both strings

my $s1 = shift // '';
my $s2 = shift // '';

my $l1 = length $s1;
my $l2 = length $s2;

die "Usage: perl $0 <string 1> <string 2>" unless $l1 && $l2;

# now we start by computing Jaro similarity

my $max_dist =
  int( ( $l1 > $l2 ? $l1 : $l2 ) / 2 ) - 1;    # as for definition in wikipedia

# we now construct two arrays with the individual chars of each string

my @arr_s1 = split '', $s1;
my @arr_s2 = split '', $s2;

my @matched2;                                  # chars matched, string 2

my @pos_m1;    # where we matched (char position) in string 1
my @pos_m2;    # same for string 1

for my $i1 ( 0 .. $#arr_s1 ) {

    # we need to compare chats only from $max_dist positions before
    # the current index, up to $max_dist positions after current index
    my $from = $i1 - $max_dist;
    $from = 0 if $from < 0;    # dont go beyond left end of string 2
    my $to = $i1 + $max_dist;
    $to = $#arr_s2 if $to > $#arr_s2;    # or beyond right end of string 2
    for my $i2 ( $from .. $to ) {
        next if $matched2[$i2];          # already matched, skip
        next unless $arr_s1[$i1] eq $arr_s2[$i2];
        $matched2[$i2] = 1;    # mark in 2nd array to avoid matching again
        push @pos_m1, $i1;     # record position for string 1
        push @pos_m2, $i2;     # and for string 2
    }
}

# note that the amount of matches is the size of both arrays @pos_m1 & 2
my $m = @pos_m1;

# now calculates transpositions. To do that, we order all matches positions
# in the same (ascending) order
# and then the matches that correspond to the same order are because
# they don't need a transposition

@pos_m1 = sort { $b <=> $a } @pos_m1;
@pos_m2 = sort { $b <=> $a } @pos_m2;

my $t = 0; # amount of transpositions needed (should be divided by 2 at the end)
for my $p ( 0 .. $#pos_m1 ) {
    my $pos1 = $pos_m1[$p];
    my $pos2 = $pos_m2[$p];
    next if $arr_s1[$pos1] eq $arr_s2[$pos2];
    $t++;
}

# now we can calculate the jaro similarity
my $jaro_sim = 0;
$jaro_sim = ( $m / $l1 + $m / $l2 + ( $m - $t / 2 ) / $m ) / 3 if $m;

# to compute jaro-winkler distance, we need the amount of common chars at the beginning of both strings

my $lpref = 0;    # amount of equal chars
$lpref++
  while $lpref <= $l1 && $lpref <= $l2 && $arr_s1[$lpref] eq $arr_s2[$lpref];

# should not be greater than 4
$lpref = 4 if $lpref > 4;

# with this and the standard factor of 0.1 (see wikipedia), we can calculate Jaro-Winkler distance:
my $jwdist = 1 - $jaro_sim - $lpref * .1 * ( 1 - $jaro_sim );

say "Jaro-Winkler distance between $s1 and $s2 is: $jwdist";
