use strict;
use warnings;

use v5.38;


my @inputs = (
    "I love Perl",
    "Perl and Raku are friends",
    "The Weekly Challenge",
    "Perl! and Raku?     are... friends>"
    );
for (@inputs) {
    say make_to_goat_latin( $_ );
}

sub make_to_goat_latin( $string ) {
    # if non-vowel initial then move to end
    $string =~ s/\b([BCDFGHJKLMNPQRSTVWXYZ])(\w+)\b/$2$1/ig;

    # suffix each (proper) word with maa, maaa, maaaa, etc.
    my $count = 0;
    $string =~ s/\b(\w+)\b/$1 . 'ma' . 'a' x ++$count/eg;
    return $string;
}
