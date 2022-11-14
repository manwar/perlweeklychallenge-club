#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use List::Util qw( uniq );
use v5.32;
use Mojo::Util qw( dumper );

=pod

Task 2: Decoded List
You are given an encoded string consisting of a
sequence of numeric characters: 0..9, $s.

Write a script to find the all valid different decodings in sorted order.

Encoding is simply done by mapping A,B,C,D,… to 1,2,3,4,… etc.

=cut

my @mapping = (
    undef,          # Skip index 0.
    'A' .. 'Z',     # 1 .. 26.
);
my $letters = $#mapping;

sub decode_list {
    my ( $s ) = @_;

    # Build pattern based on how many letters we got.
    my $is_letter = '(.+)'                      # First regex.
                  . '(.*)' x (length($s)-1);    # Rest are optional.

    # Collect combinations.
    my @list_raw;
    $s =~ /
        ^                   # Start.
            $is_letter      # Dynamic pattern.
        $                   # End.
        (?{
            push @list_raw, # Collect combo.
                join ",",
                @{^CAPTURE}     # Instead of doing ($1,$2,...$N)
        })
        (?!)                # Fail and try other options.
    /xg;

    # Cleanup the list and convert.
    my @list =
        sort
        map {
            join "",
            map { $mapping[$_] } @$_    # Convert to letter.
        }
        grep {                          # All parts must be in range.
            @$_ == grep {
                $_ and $_ >= 1 and $_ <= $letters
            } @$_;
        }
        map { [ split /,/ ] }           # Split into parts.
        uniq                            # Skip duplicates.
        grep { $_ }                     # Not empty.
        @list_raw;

    \@list;
}

my @cases = (
    {
        Name   => 'Example 0',
        Input  => '123',
        Output => [ 'ABC', 'AW', 'LC' ],
    },
    {
        Name   => 'Example 1',
        Input  => '11',
        Output => [ 'AA', 'K' ],

        # 11 can be decoded as (1 1) or (11) i.e. AA or K
    },
    {
        Name   => 'Example 2',
        Input  => '1115',
        Output => [ 'AAAE', 'AAO', 'AKE', 'KAE', 'KO' ],

        # Possible decoded data are:
        # (1 1 1 5) => (AAAE)
        # (1 1 15)  => (AAO)
        # (1 11 5)  => (AKE)
        # (11 1 5)  => (KAE)
        # (11 15)   => (KO)
    },
    {
        Name   => 'Example 3',
        Input  => '127',
        Output => [ 'ABG', 'LG' ],

        # Possible decoded data are:
        # (1 2 7) => (ABG)
        # (12 7)  => (LG)
    },
);

for ( @cases ) {
    is_deeply decode_list( $_->{Input} ), $_->{Output}, $_->{Name};
}

done_testing();
