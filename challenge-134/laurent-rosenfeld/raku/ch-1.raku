use v6;

my $start = "1023456";
my @ends = <7 8 9>.permutations[0..4]>>.join("");
say $start ~ $_ for @ends;
