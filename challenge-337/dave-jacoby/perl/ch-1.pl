#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (

    [  6, 5, 4, 8 ],
    [  7, 7, 7, 7 ],
    [  5, 4, 3,  2, 1 ],
    [ -1, 0, 3, -2, 1 ],
    [  0, 1, 1,  2, 0 ],

);

for my $in (@examples) {
    my @input  = $in->@*;
    my $input  = join ', ', @input;
    my @output = smaller_than_current(@input);
    my $output = join ', ', @output;
    say <<"END";
        Input:  \@num1 = ($input)
        Output: $output
END

}

sub smaller_than_current (@num1) {
    my @num2;
    for my $i ( 0 .. $#num1 ) {
        my $n    = $num1[$i];
        my @copy = @num1;
        delete $copy[$i];
        @copy = grep { defined } @copy;
        push @num2, scalar grep { $n >= $_ } @copy;
    }
    return @num2;
}
