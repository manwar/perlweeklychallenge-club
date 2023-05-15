#!/usr/bin/perl
use 5.030;
use warnings;

sub isSubset {
    my @subset = @{$_[0]};

    my %set;
    for my $c (@{$_[1]}) {
        $set{$c}++;
    }

    for my $c (@subset) {
        if (!exists $set{$c} || $set{$c} == 0) {
            return undef;
        }
        $set{$c}--;
    }

    return 1;
}


sub combGrepUniqueLc {
    my ($str) = @_;

    my @chars = map { lc } grep { $_ =~ /[[:alpha:]]/ } split //, $str;
 
    my %unique;
    for my $c (@chars) {
        $unique{$c}++;
    }

    return keys %unique;
}

my ($reg, @words) = @ARGV;

my @registration = combGrepUniqueLc($reg);
my @results;

for my $word (@words) {
    my @w = combGrepUniqueLc($word);
    if (isSubset(\@registration, \@w)) {
        push @results, $word;
    }
}

say q{(}, (join q{, }, map {"'$_'"} @results), q{)};
