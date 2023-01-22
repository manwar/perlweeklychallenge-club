# The Weekly Challenge 200
# Task 1 Arithmetic Slices
use v5.30.0;
use warnings;
use Algorithm::Combinatorics qw/combinations/;

my @a = @ARGV;
@a = (1,2,3,4) if scalar @ARGV == 0;

for my $i (3..1+$#a) {
    my $iter = combinations(\@a, $i);
    while (my $p = $iter->next) {
        say join ",", $p->@* if verify($p);
    }
}

sub verify {
    my @a = $_[0]->@*;
    return 0 if scalar @a < 3;
    my $diff = $a[1]-$a[0];
    for (1..$#a-1) {
        return 0 if $diff != $a[$_+1]-$a[$_];
    }
    return 1;
}
