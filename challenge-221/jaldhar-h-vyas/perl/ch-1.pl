#!/usr/bin/perl
use 5.030;
use warnings;

sub isSubset {
    my @subset = @{$_[0]};
    my %set = map { $_ => 1 } @{$_[1]};

    return (scalar grep { exists $set{$_} } @subset) == (scalar @subset);
}

sub sum {
    my ($arr) = @_;
    my $total = 0;

    for my $elem (@{$arr}) {
        $total += $elem;
    }

    return $total;
}

my @chars = split //, shift @ARGV;
my @words = @ARGV;

say sum([
    map { scalar @{$_} }
    grep { isSubset($_, \@chars) }
    map { [ split //, $_ ] }
    @words
]);
