# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-264/

# Test run:
# $ raku ch-1.raku
# PeRlwEeKLy: L
# ChaLlenge: L
# The: -

my @s = 'PeRlwEeKLy', 'ChaLlenge', 'The';
for @s -> $s {
    say "$s: " ~ solve($s);
}

sub solve($s) {
    my $chars = $s.comb.Bag;

    my @candidates = $chars.grep: * ~~ /<[A..Z]>/;
    @candidates = @candidates.grep({$chars{$_.key.lc}});

    @candidates = @candidates.sort;    

    return @candidates.elems ?? @candidates[*-1].key !! '-';
}
