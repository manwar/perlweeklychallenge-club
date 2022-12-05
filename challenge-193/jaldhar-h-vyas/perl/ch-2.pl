#!/usr/bin/perl
use 5.030;
use warnings;

my @strings = @ARGV;
my %results;

for my $string (@strings) {
    my @values = map { ord($_) - ord('a') } split //, $string;
    my @diff;

    for my $i (1 .. scalar @values - 1) {
        push @diff, $values[$i] - $values[$i - 1];
    }
    push @{$results{join(q{,}, @diff)}}, $string;
}

say $results{ (grep { scalar @{$results{$_}} == 1 } keys %results)[0] }[0];
