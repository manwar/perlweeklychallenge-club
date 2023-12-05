# The Weekly Challenge 246
# Task 1  6 out of 49
use v5.30.0;
use warnings;

my @ans;
my @arr = (1..49);
for my $i (0..5) {
    my $k = int(rand(49-$i));
    push @ans, splice(@arr, $k, 1);
}

say join "\n", sort {$a<=>$b} @ans;
