#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(reduce);
use Scalar::Util qw(looks_like_number);

{
    my ( $number ) = @ARGV;
    die "$0: expect a positive integer\n"
      if !$number
      || !looks_like_number( $number )
      || $number <= 0
      || int( $number ) != $number;
    say count_number( $number );
}

sub count_number($n) {
    my @digits = split( '', $n );

    # group adjacent elements in @digits by numerical equality
    my @groups = group_by( sub ( $a, $b ) { $a == $b }, @digits );

    # get the size and an element from each group
    my @count_digits = map { scalar( @$_ ), $_->[-1] } @groups;

    # reassemble the number and return
    return join( '', @count_digits );
}

# groups adjacent elements in @xs according to the result of comparing them by
# $compare_fn
sub group_by ( $compare_fn, @xs ) {
    return @{
        (
            reduce {
                # create new group in the first iteration and each time the
                # result of comparing last and and cur is false
                push @{ $a->{groups} }, []
                  if !exists $a->{last}
                  || !$compare_fn->( $a->{last}, $b );

                # add the current element to the latest group
                push @{ $a->{groups}[-1] }, $b;

                # set last to the current element
                $a->{last} = $b;
                $a;

            }
            { groups => [] },
            @xs,
        )->{groups}
    };
}
