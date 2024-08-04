use strict;
use warnings;

use v5.38;

sub strip_bar_segments( $str ) {
    $str =~ s/\|.*?\|//g;
    return $str;
}

sub count_stars( $str ) {
    return $str =~ tr/*//;
}

my @inputs = (
    "th|ewe|e**|k|l***ych|all|eng|e",
    "p|*e*rl|w**e|*ekly|",
    "perl"
    );

for (@inputs) {
    my $reduced = strip_bar_segments($_);
    my $count = count_stars($reduced);
    say $_ . " => " . $reduced . " :: " . $count;
}
