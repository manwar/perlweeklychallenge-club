#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

use List::Util qw{ sum0 };

my @examples = (qw{ hello perl raku weekly linux Perl PERL });

for my $example (@examples) {
    my $output = string_score($example);

    say <<"END";
        Input:  \$str = "$example"
        Output: $output
END
}

sub string_score ($str) {
    my @str = split //, $str;
    return sum0
        map { abs ord( $str[$_] ) - ord( $str[ 1 + $_ ] ) }
        0 .. -2 + scalar @str;
}
