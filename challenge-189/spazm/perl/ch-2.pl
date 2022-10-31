#!/usr/bin/env perl

use v5.30;
use Data::Dumper;
use experimental qw/signatures/;

sub array_degree (@input)
{
    say @input;
    my %cnt;
    my @max;
    my $len = 0;
    my %loc;
    my $min_len = scalar @input;
    my ( $max, $max_c ) = 0, undef;
    for my $i ( 0 .. $#input )
    {
        my $c = $input[$i];
        $cnt{$c}++;
        if ( $cnt{$c} > $max )
        {
            $max = $cnt{$c};
        }
        push @{ $loc{$c} }, $i;
        if ( $max_c == $c )
        {
            $max++;
            $len++;
        }
        elsif ( $cnt{$c} > $max )
        {
            $max   = $cnt{$c};
            $max_c = $c;
            $len   = 1;
        }
        else
        {
            $len++;
        }
        $max[$i] = [ $max, [ $max_c, $c ], $len ];
    }
    my @maxes;
    my @sol_index;
    while ( my ( $key, $value ) = each %cnt )
    {
        if ( $value == $max )
        {
            my $loc = $loc{$key};
            my ( $first, $last ) = ( $loc->[0], $loc->[-1] );
            my $len = $last - $first;
            say Dumper {
                loc     => $loc,
                first   => $first,
                last    => $last,
                len     => $len,
                min_len => $min_len
            };
            if ( $len < $min_len )
            {
                say "new min len: $len";
                $min_len   = $len;
                @sol_index = ( $first, $last );
            }
            say Dumper { min_len => $min_len, sol => \@sol_index };
        }
        push @maxes, $key if $value == $max;
    }
    say @input;

    #say Dumper \@max;
    say Dumper \%loc;
    say Dumper \%cnt;
    say $max;
    say Dumper @maxes;
    my @answer = @input[@sol_index];
    say Dumper { min_len => $min_len, indices => \@sol_index,
        answer => \@answer };
    return @answer;
}

array_degree( 1, 3, 3, 2, 1 );
{
    use Test::More;
    is_deeply \array_degree( 1, 3, 3, 2 ), [ 3, 3 ];
    is_deeply \array_degree( 1, 2, 1, 3 ), [ 1, 2, 1 ];
    is_deeply \array_degree( 1, 3, 2, 1, 2 ), [ 3, 3 ];
    is_deeply \array_degree( 1, 1, 2, 3, 2 ), [ 3, 3 ];
    is_deeply \array_degree( 2, 1, 2, 1, 2 ), [ 1, 2, 1, 1 ];
    done_testing;
}
