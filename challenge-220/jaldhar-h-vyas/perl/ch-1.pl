#!/usr/bin/perl
use 5.030;
use warnings;

sub intersection {
    my ($arrays, $n) = @_;
    my %count;

    for my $arr (@{$arrays}) {
        for my $char (@{$arr}) {
            $count{$char}++;
        }
    }

    return grep { $count{$_} >= $n} keys %count;
}

my @words = map { [map { lc } split //] } @ARGV;
my @common = intersection(\@words, scalar @ARGV);

say q{("}, (join q{", "}, sort @common), q{")};