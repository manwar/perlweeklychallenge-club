#!/usr/bin/env perl

use v5.30;
use Data::Dumper;
use experimental qw/signatures/;

sub array_degree (@input)
{
    my %cnt;
    my %loc;
    my $min_len = scalar @input;
    my $max     = 0;
    for my $i ( 0 .. $#input )
    {
        my $c = $input[$i];

        # build a mapping of input element to count
        $cnt{$c}++;
        $max = $cnt{$c} if ( $cnt{$c} > $max );

# build a mapping of input element to array of indexes where that element is found
# this could be tightened up by keeping only the first and last element
        push @{ $loc{$c} }, $i;
    }
    my @sol_index;
    while ( my ( $key, $value ) = each %cnt )
    {
        if ( $value == $max )
        {
         # For all input elements appearing max times,
         # find the shortest delta between first and last appearance.
         # Minimal solutions will extend from first to last of a given element
            my $loc = $loc{$key};
            my ( $first, $last ) = ( $loc->[0], $loc->[-1] );
            my $len = $last - $first;
            if ( $len < $min_len )
            {
                $min_len   = $len;
                @sol_index = ( $first, $last );
            }
        }
    }
    @input[ $sol_index[0] .. $sol_index[1] ];
}

{
    use Test::More;
    is_deeply [ array_degree( 1, 3, 3, 2 ) ], [ 3, 3 ];
    is_deeply [ array_degree( 1, 2, 1, 3 ) ], [ 1, 2, 1 ];
    is_deeply [ array_degree( 1, 3, 2, 1, 2 ) ], [ 2, 1, 2 ];
    is_deeply [ array_degree( 1, 1, 2, 3, 2 ) ], [ 1, 1 ];
    is_deeply [ array_degree( 2, 1, 2, 1, 1 ) ], [ 1, 2, 1, 1 ];
    done_testing;
}
