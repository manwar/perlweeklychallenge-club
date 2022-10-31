#!/usr/bin/env perl

use v5.30;

use experimental qw/signatures/;

sub greater_character ( $chars, $target )
{
    @$chars = sort { $a gt $b } @$chars;
    for my $char (@$chars)
    {
        return $char if $char gt $target;
    }
    return $target;
}

{
    use Test::More;
    is greater_character( [qw/e m u g/], 'b' ), 'e';
    is greater_character( [qw/d c e f/], 'a' ), 'c';
    is greater_character( [qw/j a r/],   'o' ), 'r';
    is greater_character( [qw/d c a f/], 'a' ), 'c';
    is greater_character( [qw/t g a l/], 'v' ), 'v';
    done_testing;
}
