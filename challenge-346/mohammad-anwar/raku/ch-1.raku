#!/usr/bin/env raku

use Test;

my @examples = (
    { str => '(()())',        exp => 6 },
    { str => ')()())',        exp => 4 },
    { str => '((()))()(((()', exp => 8 },
    { str => '))))((()(',     exp => 2 },
    { str => '()(()',         exp => 2 },
);

for @examples -> %example {
    is(valid-longest-parenthesis(%example<str>), %example<exp>);
}

done-testing;

sub valid-longest-parenthesis(Str $s) {
    my @stack   = (-1);
    my $max-len = 0;

    for 0 .. $s.chars - 1 -> $i {
        if $s.substr($i, 1) eq "(" {
            @stack.push($i);
        } else {
            @stack.pop();
            if @stack.elems > 0 {
                $max-len = $max-len > ($i - @stack[*-1])
                           ?? $max-len
                           !! ($i - @stack[*-1]);
            } else {
                @stack.push($i);  # New starting point
            }
        }
    }

    return $max-len;
}
