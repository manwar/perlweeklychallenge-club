#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

sub compare {
    my ($n,$m)=@_;
    $n =~ s/_/!/g;
    $m =~ s/_/!/g;
    $n =~ s/\d+/0|$&/ge;
    $m =~ s/\d+/0|$&/ge;
    $n cmp $m;
}

my @num_set = (
    [qw(0.1     1.1)],
    [qw(2.0     1.2)],
    [qw(1.2     1.2_5)],
    [qw(1.2.1   1.2_1)],
    [qw(1.2.1   1.2.1)],
);

#leading 0's are ignored such that 1.002 is eq 1.2
for my $num (@num_set) {
    my $c = compare(@{$num});
    printf "%10s %s %-10s %2s\n", $num->[0], qw(< 0 >)[$c+1], $num->[1], $c ;
}

=begin
perl .\ch-1.pl
       0.1 < 1.1        -1
       2.0 > 1.2         1
       1.2 < 1.2_5      -1
     1.2.1 > 1.2_1       1
     1.2.1 0 1.2.1       0
=cut