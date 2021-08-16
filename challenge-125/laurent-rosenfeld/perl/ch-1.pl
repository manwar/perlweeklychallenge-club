use strict;
use warnings;
use feature qw/say/;

my $max = 300;
my @squares = map  $_ * $_ , 1..$max;
my %square_hash = map { $_ => 1 } @squares;
my @combinations;
for my $i (2..200) {
    push @combinations, [$i, $_] for $i+1 .. $max;
}
my @triples;
for my $comb (@combinations) {
    my $sum_sq = $comb->[0] ** 2 + $comb->[1] ** 2;
    push @triples, [ @$comb, 0 + $sum_sq ** 0.5 ] if exists $square_hash{$sum_sq};
}
my %look_up = (0 => " [ -1 ] ", 1 => " [ -1 ] ", 2 => " [ -1 ] " );
for my $triple (@triples) {
    for my $val (@$triple) {
        $look_up{$val} .= " [ @$triple ] " ;
    }
}
for my $test (1..30) {
    my $result = $look_up{$test};
    say "$test:\t $result";
}
