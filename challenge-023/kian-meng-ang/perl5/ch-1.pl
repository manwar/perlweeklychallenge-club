#!/usr/bin/env perl
# vi:et:sw=4 ts=4 ft=perl

use strict;
use warnings;
use utf8;
use feature qw(say);
use constant USAGE => qq|USAGE: perl $0 <order> <n1,n2,...,nN>|;
use Carp;

my $order = $ARGV[0] || croak USAGE;
my @seq = split /,/, $ARGV[1] || croak USAGE;
scalar @seq > $order || croak q|ERROR: Total sequence of number must larger than order|;

my @trace;
foreach my $o (1 .. $order) {
    my @nseq;
    foreach my $s (1 .. scalar @seq - 1) {
        push @nseq, $seq[$s] - $seq[$s - 1];
    }
    push @trace, \@nseq;
    @seq = @nseq;
}

foreach (0 .. scalar @trace - 1) {
    say sprintf q|order:%s seq:%s|, $_ + 1, join q|,|, @{$trace[$_]};
}

1;

__END__

$ perl ch-1.pl
USAGE: perl ch-1.pl <order> <n1,n2,...,nN> at ch-1.pl line 10

$ perl ch-1.pl 1
USAGE: perl ch-1.pl <order> <n1,n2,...,nN> at ch-1.pl line 11.

$ perl ch-1.pl 1 5
ERROR: Total sequence of number must larger than order at ch-1.pl line 12.

$ perl ch-1.pl 5 5,9,2,8,1,6
order:1 seq:4,-7,6,-7,5
order:2 seq:-11,13,-13,12
order:3 seq:24,-26,25
order:4 seq:-50,51
order:5 seq:101
