#!/usr/bin/perl
use 5.030;
use warnings;

sub makeBag {
    my ($string) = @_;
    my %bag;

    for my $c (split //, $string) {
        $bag{$c}++;
    }

    return %bag;
}

my ($source, $target) = @ARGV;
my %s = makeBag($source);
my %t = makeBag($target);

say 0+(scalar grep { !exists $s{$_} || $s{$_} < $t{$_} } keys %t) ? 'false' : 'true';
