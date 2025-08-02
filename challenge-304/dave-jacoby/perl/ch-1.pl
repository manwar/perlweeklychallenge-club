#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{any};

my @examples = (

    { n => 1, digits => [ 1, 0, 0, 0, 1 ], },
    { n => 2, digits => [ 1, 0, 0, 0, 1 ], },
);

for my $example (@examples) {
    my $n      = $example->{n};
    my @digits = $example->{digits}->@*;
    my $digits = join ', ', @digits;
    my $output = rearrange_binary($example);
    say <<"END";
    Input:  \@digits = ($digits), \$n = $n
    Output: $output
END
}

sub rearrange_binary($example) {
    my $n      = $example->{n};
    my @digits = $example->{digits}->@*;
    my @output;
    my $d = $#digits;
    return 'false' unless test(@digits);
    if ( $n == 0 ) {
        return 'true';
    }
    for my $i ( 0 .. $d ) {
        next if $digits[$i] == 1;
        my @new = @digits;
        $new[$i] = 1;
        push @output , rearrange_binary( { digits => \@new, n => $n - 1 } );
    }
    return 'true' if any { $_ eq 'true' } @output;
    return 'false';
}

sub test (@array) {
    my $d = $#array;
    for my $i ( 1 .. $d ) {
        return 0 if $array[$i] == 1 && $array[ $i - 1 ] == 1;
    }
    return 1;
}