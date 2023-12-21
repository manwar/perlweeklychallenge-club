#!/usr/bin/env raku
use v6.d;

#
# Copyright © 2023 Joelle Maslak
# All Rights Reserved - See License
#

sub MAIN(Str:D $str = "loveleetcode", Str:D $char = "e") {
    if $char.chars ≠ 1 {
        say("You must provide exactly one letter as your character input.");
        return 1;
    }
    my @c = $str.split("", :skip-empty);
    my @positions;
    for @c.kv -> $i, $letter {
        @positions.push($i) if $letter eq $char;
    }

    if @positions.elems == 0 {
        say("The letter '$char' is not found.");
        return 2;
    }

    my $prev = @c.elems;
    my $next = shift @positions;
    my @output;
    for @c.keys -> $i {
        if $next == $i {
            @output.push: 0;
            $prev = $next;
            $next = @positions.elems ?? shift @positions !! @c.elems;
        } else {
            @output.push: min abs($i - $prev), abs($next  - $i);
        }
    }

    say "(" ~ @output.join(",") ~ ")";
    return 0;
}


