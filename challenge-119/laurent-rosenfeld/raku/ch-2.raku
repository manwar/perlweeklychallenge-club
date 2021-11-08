use v6;

my $seq-no_1 = grep { not /11 | 0 / }, map { $_.base(4) },
    1..Inf;
say $seq-no_1[$_ - 1] for 5, 10, 60;
