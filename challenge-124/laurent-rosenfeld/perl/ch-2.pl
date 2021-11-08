use strict;
use warnings;
use feature "say";

my @comb;

sub combine {
    my $count = shift;
    my @out = @{$_[0]};
    my @in  = @{$_[1]};
    if ($count == 0) {
        push @comb, [@out];
        return;
    }
    for my $i (0..$#in) {
        combine ($count - 1, [@out, $in[$i]], [@in[0..$i -1], @in[$i+1..$#in]]);
    }
}

sub sum {
    my $sum = 0;
    $sum += $_ for @_;
    return $sum;
}

sub find_smallest_diff {
    my @in = @{$_[0]};
    my $min_val;
    my $min_seq;
    for my $c (@comb) {
        my @c1 = @$c;
        my %seen = map { $_ => 1 } @c1;
        my @c2 = grep  { not exists $seen{$_}} @in;
        my $diff = abs(sum(@c2) - sum(@c1));
        $min_val = $diff unless defined $min_val;
        if ($diff < $min_val) {
            $min_val = $diff;
            $min_seq = ("@c1 -- @c2 ");
        }
    }
    return "$min_seq => $min_val";
}

for my $test ( [10, 20, 30, 40, 50, 60, 70, 80, 90, 100],
               [10, -15, 20, 30, -25, 0, 5, 40, -5] ) {
    my $count = int (@$test / 2);
    combine $count, [], $test;
    say find_smallest_diff $test;
}
