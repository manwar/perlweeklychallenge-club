#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{min};

my @examples = (

    [ 4 ], # win from beginning
    [ 4, 1 ], # one-round win
    [ 2, 3, 1, 1, 4 ],
    [ 2, 3, 0, 4 ],
    [ 2, 0, 0, 4 ], # unwinnable
);

for my $example (@examples) {
    my $output = jump_game($example);
    my $input  = join ', ', $example->@*;
    say <<"END";
    Input:  \$ints = ($input)
    Output: $output
END
}

sub jump_game ( $ints, $position = 0, $depth = 0 ) {
    my @output;
    my $last = -1 + scalar @$ints;          # address of target
    return $depth if $position == $last;    # win condition
    return        if $position > $last;     # lose condition
    my $v = $ints->[$position];
    for my $i ( 1 .. $v ) {     # zero means infinite loop
        my $j = $i + $position; # next position
        push @output, jump_game( $ints, $j, $depth + 1 );
    }
    @output = grep {$_ > -1} @output;
    return min @output if scalar @output;
    return -1;
}

