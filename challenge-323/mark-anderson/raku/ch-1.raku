#!/usr/bin/env raku
use Test;

is increment-decrement(<--x x++ x++>),     1;
is increment-decrement(<x++ ++x x++>),     3;
is increment-decrement(<x++ ++x --x x-->), 0;

sub increment-decrement(@operations)
{
    my %m is Map = @operations.classify({ .contains('+') });
    quietly %m<True> - %m<False>
}
