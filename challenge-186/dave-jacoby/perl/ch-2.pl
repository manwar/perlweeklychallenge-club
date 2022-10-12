#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use utf8;    # so we can use UTF8 chars within the code
binmode STDOUT, ":encoding(UTF-8)";    # so they print OK

use Unicode::Normalize;

my @words = qw{
    AEIOU
    aeiou
    ÃÊÍÒÙ
    âÊíÒÙ
};

for my $word (@words) {
    my $out = makeover($word);
    say << "END";
    Input:  $word
    Output: $out
END
}

sub makeover ( $str ) {
    my $output;
    for my $c ( split //mx, $str ) {
        my $d = NFKD($c);
        $d =~ s/\p{NonspacingMark}//g; # the important part
        $output .= $d ;
    }
    return $output;
}
