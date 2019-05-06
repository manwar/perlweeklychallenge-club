#!/usr/bin/env perl

use 5.010;
use strict;
use warnings;
use utf8;
use Carp;

carp 'missing word and dictionary file' if (@ARGV != 1);

my ($series) = @ARGV;
my @numbers =  split /,/, $series;

my (@sequence, @group);
for my $i (1 .. $#numbers) {
    if ($numbers[$i] - $numbers[$i-1] == 1) {
        push @group, $numbers[$i-1] if (scalar @group == 0);
        push @group, $numbers[$i];
    }
    else {
        push @sequence, [@group];
        @group = ();
    }

    if ($i == $#numbers) {
        push @sequence, [@group];
        @group = ();
    }
}

my @shorter_series;
foreach my $s (@sequence) {
    if (scalar @{$s} >= 3) {
        push @shorter_series, sprintf '%d-%d', shift @{$s}, pop @{$s};
    }
    else {
        push @shorter_series, @{$s};
    }
}

say join q|,|, @shorter_series;

1;

__END__
$ perl ch-1.pl 1,2,3,4,9,10,14,15,16
1-4,9,10,14-16
# vi:et:sw=4 ts=4 ft=perl
