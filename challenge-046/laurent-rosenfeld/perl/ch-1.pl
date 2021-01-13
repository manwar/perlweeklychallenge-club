use strict;
use warnings;
use feature "say";

my $garbled = <<'END_MSG';
P + 2 l ! a t o
1 e 8 0 R $ 4 u
5 - r ] + a > /
P x w l b 3 k \
2 e 3 5 R 8 y u
< ! r ^ ( ) k 0
END_MSG

my @AoA = map { [ split /\s+/, $_] } split /[\r\n]+/, $garbled;
my @transposed;
for my $i (0 .. $#AoA) {
  $transposed[$_][$i] = $AoA[$i][$_] for 0.. scalar @{$AoA[$i]} -1;
}
my @msg = "";
for my $line_ref (@transposed) {
    my %counter;
    $counter{$_}++ for @$line_ref;
    push @msg, grep { $counter{$_} > 1 } keys %counter;
}
say @msg;
