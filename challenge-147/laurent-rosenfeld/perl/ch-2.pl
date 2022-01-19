use strict;
use warnings;
use feature "say";
use constant MAX => 4000;

my @pentanums = map { $_ * (3 * $_ - 1)/2 } 1..MAX;
my %penta_h = map {$pentanums[$_] => $_+1 } 0..MAX-1;
# say Dumper \%penta_h;

OUTER: for my $i (0..MAX-1) {
    for my $j ($i+1..MAX-1) {
        my $sum = $pentanums[$i] + $pentanums[$j];
        next unless exists $penta_h{$sum};
        my $diff = $pentanums[$j] - $pentanums[$i];
        next unless exists $penta_h{$diff};
        say "First pair of pentagon numbers is $pentanums[$i] (rank ", $i+1, ") and $pentanums[$j] (rank ", $j+1, ")";
        say "Sum is $sum (rank $penta_h{$sum}) and difference is $diff (rank $penta_h{$diff})";
        last OUTER;
    }
}
