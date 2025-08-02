#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ sum0 };

my @examples = (

    [ 1, 2, 3, 4 ],
    [ 2, 7, 1, 19, 18, 3 ],
);

for my $example (@examples) {
    my $input  = join ', ', $example->@*;
    my $output = special_numbers( $example->@* );

    say <<~"END";
    Input:  \$ints = ($input)
    Output: $output
    END
}

sub special_numbers (@input) {
    my $output = 0;
    my $n      = scalar @input;
    return 
        sum0 
        map { $input[ $_ - 1 ] ** 2 } 
        grep { $n % $_ == 0 } 
        1 .. scalar @input;

    ## the longer form I wrote first
    # for my $i ( 1 .. scalar @input ) {
    #     if ( $n % $i == 0 ) {
    #         my $v = $input[ $i - 1 ];
    #         $output += ( $v**2 );
    #     }
    # }
    # return $output;
}
