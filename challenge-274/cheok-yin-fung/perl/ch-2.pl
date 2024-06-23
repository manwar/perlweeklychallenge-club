# The Weekly Challenge 274
# Task 2 Bus Route
# Example 1 Calculation only, too lazy
use v5.30.0;
use warnings;
use List::Util qw/first/;
my $r1 = [12, 11, 41];
my $r2 = [15,  5, 35];

my $a1 = [$r1->[1]];
my $a2 = [$r2->[1]];
while ($a1->[-1]+$r1->[0] < 60) {
    push $a1->@*, $a1->[-1]+$r1->[0];
}
while ($a2->[-1]+$r2->[0] < 60) {
    push $a2->@*, $a2->[-1]+$r2->[0];
}
my $d1 = [map {$r1->[2]+$_} $a1->@*];
my $d2 = [map {$r2->[2]+$_} $a2->@*];

for my $i (0..59) {
    my $p1 = first {$a1->[$_] >= $i} 0..$a1->$#*;
    my $p2 = first {$a2->[$_] >= $i} 0..$a2->$#*;
    if (defined($p1) && defined($p2)) {
        if ($a1->[$p1] < $a2->[$p2] && $d1->[$p1] > $d2->[$p2]) {
            print "$i, ";
        }
        if ($a1->[$p1] > $a2->[$p2] && $d1->[$p1] < $d2->[$p2]) {
            print "$i, ";
        }
    }
}
print "\n";
