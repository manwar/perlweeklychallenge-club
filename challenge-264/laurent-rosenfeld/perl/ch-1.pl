use strict;
use warnings;
use feature 'say';

sub greatest_eng_let {
    my @in = split //, shift;
    my %uc = map { $_ => 1 } grep { $_ le 'Z' } @in;
    my @common =  grep { exists $uc{$_}}
                 map { uc } grep {$_ gt 'Z'} @in;
    return (sort @common)[-1] // "''";
}

my @tests = qw < PeRlwEeKLy ChaLlenge The >;
for my $test (@tests) {
    printf "%-15s => ", $test;
    say greatest_eng_let $test;
}
