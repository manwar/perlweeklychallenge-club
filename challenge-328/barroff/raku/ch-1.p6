#!/usr/bin/env raku

use v6.d;

sub replace-all-q(Str $str --> Str) {
    return $str unless $str.contains('?');
    my @chars = $str.comb;
    if @chars[0] eq '?' {
        @chars[0] = @chars[1] eq 'a' ??  'b' !! 'a';
    }
    for 1..@chars.elems - 2 {
        if @chars[$_] eq '?' {
            my $surroundings = Set(@chars[$_ - 1], @chars[$_ + 1]);
            if 'a' ∉ $surroundings {
                @chars[$_] = 'a';
            } elsif 'b' ∉ $surroundings {
                @chars[$_] = 'b';
            } else {
                @chars[$_] = 'c';
            }
        }
    }
    @chars.join;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is replace-all-q("a?z"), "abz", 'works for "a?z"';
    is replace-all-q("pe?k"), "peak", 'works for "pe?k"';
    is replace-all-q("gra?te"), "grabte", 'works for "gra?te"';
}

#| Take user provided string like "a?z"
multi sub MAIN(Str $str) {
    say replace-all-q($str);
}
