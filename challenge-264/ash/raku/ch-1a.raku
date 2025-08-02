# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-264/

# Test run:
# $ raku ch-1a.raku
# PeRlwEeKLy: L
# ChaLlenge: L
# The: -

my @s = 'PeRlwEeKLy', 'ChaLlenge', 'The';
for @s -> $s {
    say "$s: " ~ solve($s);
}

sub solve($s) {
    my @chars = $s.comb;

    my @lc = @chars.grep: * ~~ /<[a..z]>/;
    my @uc = @chars.grep: * ~~ /<[A..Z]>/;
    @lc.=map: *.uc;

    my $x = @lc ∩ @uc; # $x is a Set

    return $x ?? $x.keys.sort[*-1] !! '-';
}
