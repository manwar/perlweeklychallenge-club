use strict;
use warnings;
use feature "say";

sub cross {
    my @nums = @_;
    my @num_pairs;
    for my $i (@nums) {
        for my $j (@nums) {
            next if $j > $i; # filter out duplicates such as [12, 3] and [3, 12]
            push @num_pairs, [$i, $j];
        }
    }
    return @num_pairs;
}

sub stealthy_nums  {
    my $n = shift;
    my @divisors = grep {$n % $_ == 0} 1..$n;
    my @div_pairs = grep { $_->[0] * $_->[1] == $n } cross @divisors;
    for my $c (@div_pairs) {
        for my $d (@div_pairs) {
            return "@$c and @$d" if abs($c->[0] + $c->[1] - $d->[0] - $d->[1]) == 1;
        }
    }
    return 0;
}

for my $test (qw <36 12 6>) {
    my $result = stealthy_nums $test;
    say "$test \t",
    $result ? "1 -> $result" : 0;
}
