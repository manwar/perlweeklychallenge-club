use strict;
use warnings;

use v5.38;

sub strip_bar_segments( $str ) {
    # remove sections between 2 bars
    $str =~ s/\|.*?\|//g;
    return $str;
}

sub count_stars( $str ) {
    # count the stars
    return $str =~ tr/*//;
}

my @inputs = (
    "th|ewe|e**|k|l***ych|all|eng|e",
    "p|*e*rl|w**e|*ekly|",
    "perl"
    );

for (@inputs) {
    # cut out inter-bar sections
    my $reduced = strip_bar_segments($_);
    # and count the remaining stars
    my $count = count_stars($reduced);
    say $_ . " => " . $reduced . " :: " . $count;
}
