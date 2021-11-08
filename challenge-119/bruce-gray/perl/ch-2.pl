#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;
use experimental qw<signatures>;

# Generator, with state in-between calls.
# Translation of my `X~` Raku solution, with additional separation by leading digit,
# to remove the need for grep'ing out the /11/.
sub s123 ( $n ) {
    state @s;
    state $last = [ [], [], [""] ];
    while ( not defined $s[$n] ) {
        push @s,            @{$last->[0]},@{$last->[1]},@{$last->[2]};

        $last = [
            [ map { "1$_" }               @{$last->[1]},@{$last->[2]} ],
            [ map { "2$_" } @{$last->[0]},@{$last->[1]},@{$last->[2]} ],
            [ map { "3$_" } @{$last->[0]},@{$last->[1]},@{$last->[2]} ],
        ];
    }
    return $s[$n];
}

my @in = @ARGV ? @ARGV : (5,10,60,14410);
say $_, " ==> ", s123($_) for @in;
