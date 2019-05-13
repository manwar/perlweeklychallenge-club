use strict;
use warnings;
use feature qw/say/;
sub edit_distance {
    my ($word1, $word2) = @_;
    die "Words $word1 and $word2 have different lengths\n" unless length $word1 == length $word2;
    my @w1 = split //, $word1;
    my @w2 = split //, $word2;
    my $dist = 0;
    for my $i (0..$#w1) {
        $dist++ if $w1[$i] ne $w2[$i];
    }
    return $dist;
}
for my $word_pair_ref (["cold", "cord"], ["cord", "core"], ["cord", "cord"],
        ["cold", "warm"], ["kitten", "sittin"], ["kitten", "sitting"]) {
    my ($w1, $w2) = @$word_pair_ref;
    say "Distance between $w1 and $w2 is: \t", edit_distance ($w1, $w2);
}
