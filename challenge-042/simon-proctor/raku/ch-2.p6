#!/usr/bin/env perl6

use v6;

#| Generate a random string of brackets then test if they are balanced
sub MAIN() {
    my $brackets = ("(",")").roll( (1..25).pick() * 2 ).join("");
    say "String to test {$brackets}";
    say "Balanced? {balanced($brackets)}";
}

sub balanced( Str \brackets ) {
    my @list = brackets.comb("");
    my $count = 0;
    for @list -> \bracket {
        given bracket {
            when "(" {
                $count++;
            }
            when ")" {
                $count--;
            }
        }
        return False if $count < 0;
    }
    return $count == 0;
}
