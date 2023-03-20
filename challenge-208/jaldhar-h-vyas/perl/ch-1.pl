#!/usr/bin/perl
use 5.030;
use warnings;

my @strings = @ARGV;

my @list1;
my @list2;
my $destination = 'first';

for my $string (@strings) {
    if ($string eq '-') {
        $destination = 'second';
        next;
    }
    if ($destination eq 'first') {
        push @list1, $string;
    } elsif ($destination eq 'second') {
        push @list2, $string;
    }
}

my %common;

for my $i (0 .. scalar @list1 - 1) {
    $common{$list1[$i]}->[0] = $i;
    unless (exists $common{$list1[$i]}->[1]) {
        $common{$list1[$i]}->[1] = -1;
    }
}

for my $i (0 .. scalar @list2 - 1) {
    unless (exists $common{$list2[$i]}->[0]) {
        $common{$list2[$i]}->[0] = -1;
    }
    $common{$list2[$i]}->[1] = $i;
}

my %indexsum;

for my $string (keys %common) {
    if ($common{$string}->[0] != -1 && $common{$string}->[1] != -1) {
        $indexsum{$string} = $common{$string}->[0] + $common{$string}->[1];
    }
}

my $minimumindex = (sort { $a <=> $b } values %indexsum)[0];

say q{(} . (
    join q{, },
    sort
    map { q{"} . $_ . q{"}}
    grep { $indexsum{$_} == $minimumindex }
    keys %indexsum
) . q{)};
