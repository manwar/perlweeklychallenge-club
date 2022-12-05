#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = qw{ abbc xyzyyxz xzxz };
for my $e (@examples) {
    my $o = analyze($e);
    say <<"END";
    Input:  \$s = '$e'
    Output: $o
END
}

sub analyze( $string ) {
    my $count  = count_chars($string);
    my @values = values $count->%*;

    for my $i ( 0 .. -1 + scalar @values ) {
        my $j     = $values[$i];
        my @array = @values;
        $array[$i] = undef;
        @array = grep { defined } @array;
        my $c = 0;
        my $d = scalar @array;
        for my $v ( @array ) {
            $c++ if $v + 1 == $j;
        }
        return 1 if $c == $d;
    }

    return 0;
}

sub count_chars ( $string ) {
    my $output;
    for my $i ( 0 .. -1 + length $string ) {
        $output->{ substr $string, $i, 1 }++;
    }
    return $output;
}
