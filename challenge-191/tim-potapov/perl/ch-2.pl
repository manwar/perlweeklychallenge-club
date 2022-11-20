#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use Math::Combinatorics qw( permute );

#TODO: Remove this debug code !!!
use feature    qw(say);
use Mojo::Util qw(dumper);

=pod

Task 2: Cute List
You are given an integer, 0 < $n <= 15.

Write a script to find the number of orderings of numbers that form a cute list.

With an input @list = (1, 2, 3, .. $n) for positive integer $n,
an ordering of @list is cute if for every entry, indexed with a base of 1, either

    1) $list[$i] is evenly divisible by $i
    or
    2) $i is evenly divisible by $list[$i]

=cut

sub number_of_orderings {
    my ( $n ) = @_;
    my @lists = permute( 1 .. $n );
    my %orderings;

  LIST:
    for my $list ( @lists ) {
        while ( my ( $i, $entry ) = each @$list ) {
            my $check1 = $list->[$i] % ( $i + 1 ) == 0;
            my $check2 = ( $i + 1 ) % $list->[$i] == 0;
            next LIST unless $check1 or $check2;
        }
        $orderings{"@$list"}++;
    }

    %orderings;
}

my @cases = (
    {
        Name   => 'Example 1',
        Input  => 2,
        Output => 2,

      # Since $n = 2, the list can be made up of two integers only i.e. 1 and 2.
      # Therefore we can have two list i.e. (1,2) and (2,1).
      # @list = (1,2) is cute since
      # $list[1] = 1 is divisible by 1 and $list[2] = 2 is divisible by 2.

    },
    {
        Name   => 'Example 2',
        Input  => 3,
        Output => 3,
    },
    {
        Name   => 'Example 2',
        Input  => 4,
        Output => 8,
    },
);

for ( @cases ) {
    is number_of_orderings( $_->{Input} ), $_->{Output},
      "$_->{Name} - $_->{Input}";
}

done_testing();
