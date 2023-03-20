#!/usr/bin/perl
use 5.030;
use warnings;

my @nums = @ARGV;
my $missing;
my %count;

for my $i (0 .. scalar @nums - 1) {
    $count{$nums[$i]}++;

    if ($i > 0 && $nums[$i] - $nums[$i - 1] > 1) {
        $missing = $nums[$i] - 1;
    }
}

my $duplicate //= (grep { $count{$_} > 1; } keys %count)[0];

if ($duplicate) {
    if ($duplicate == $nums[-1]) {
        $missing = $nums[-1] + 1;
    }

    say q{(} . (join q{,}, ($duplicate, $missing)) . q{)};
} else {
    say "-1";
}
