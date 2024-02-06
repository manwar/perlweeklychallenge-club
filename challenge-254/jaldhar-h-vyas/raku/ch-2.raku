#!/usr/bin/raku

sub MAIN(
    Str $s
) {
    my @chars = $s.comb;
    my @vowels;

    for @chars.keys -> $c {
        if @chars[$c] ∈ <a A e E i I o O u U> {
            @vowels.push(@chars[$c]);
        }
    }

    for @chars.keys -> $c {
        if @chars[$c] ∈ <A E I O U> {
            @chars[$c] = @vowels.pop.uc;
        }
        elsif @chars[$c] ∈ <a e i o u> {
            @chars[$c] = @vowels.pop.lc;
        }
    }

    @chars.join.say;
}
