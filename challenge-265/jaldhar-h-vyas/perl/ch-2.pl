#!/usr/bin/perl
use 5.030;
use warnings;

sub isSubset {
    my ($a, $b) = @_;

    for my $k (keys %{$a}) {
        unless (exists $b->{$k}) {
            return undef;
        }
        if ($a->{$k} > $b->{$k}) {
            return undef;
        }
    }

    return 1;
}

sub makeBag {
    my ($array) = @_;
    my %bag;
    for my $c (@{$array}) {
        $bag{$c}++;
    }

    return %bag;
}

my ($str, @str) = @ARGV;

my %letters = makeBag([grep { $_ =~ /[a-z]/ } split //, lc $str]);

my @completed;

foreach my $word (@str) {
    my %wordBag = makeBag([split //, $word]);
    if (isSubset(\%letters, \%wordBag)) {
        push @completed, $word;
    }
}

say ((sort { length $a <=> length $b } @completed)[0]);