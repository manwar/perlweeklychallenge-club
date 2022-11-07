#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

my @input = qw( Perl TPF PyThon raku);

for my $input (@input) {
    my $output = capital_detect( $input );
    say <<"END";
        Input:  \$s = '$input'
        Output: $output
END
}

sub capital_detect ( $input ) {
    return 1 if $input eq uc $input;
    return 1 if $input eq lc $input;
    return 1 if $input eq ucfirst lc $input;
    return 0;
}
