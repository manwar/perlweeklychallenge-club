#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-009/
# Challenge #2
# Write a script to perform different types of ranking as described below:
# 1. Standard Ranking (1224):
#  Items that compare equal receive the same ranking number,
#  and then a gap is left in the ranking numbers.
# 2. Modified Ranking (1334):
#  It is done by leaving the gaps in the ranking numbers before the sets of equal-ranking items.
# 3. Dense Ranking    (1223):
#  Items that compare equally receive the same ranking number,
#  and the next item(s) receive the immediately following ranking number.
# For more information, please refer to wiki page.
# https://en.wikipedia.org/wiki/Ranking

use strict;
use warnings;

my %valid_rankings = (
    'standard' => 'Items that compare equal receive the same ranking number,
     and then a gap is left in the ranking numbers.',
    'modified' => 'It is done by leaving the gaps in the ranking numbers
     before the sets of equal-ranking items',
    'dense' => 'Items that compare equally receive the same ranking number,
     and the next item(s) receive the immediately following ranking number.'
);

my $ranking = $ARGV[0];
usage() unless ($ranking && exists $valid_rankings{$ranking});


my %data = load_data();
my @sorted_data = sort keys %data;

print ucfirst $ranking . ' ranking for marathon times'.$/;
my $n = $ranking eq 'modified' ? 0 : 1;

foreach my $pos (@sorted_data) {
    # mark positions with same ranking
    my $mark = @{$data{$pos}} > 1 ? '*' : ' ';

    # not the best way, but it shows the differences between the algorithms
    $n += @{$data{$pos}} if ($ranking eq 'modified');
    do { print sprintf("%3d%s => %s: %s", $n, $mark, $pos, $_).$/ } for @{$data{$pos}};
    $n += @{$data{$pos}} if ($ranking eq 'standard');
    $n++ if ($ranking eq 'dense');
}

sub usage {
    print "Usage: $0 <ranking>".$/.$/;
    print "Valid <ranking> values:".$/;
    print " '$_': $valid_rankings{$_}".$/ foreach (reverse sort keys %valid_rankings);
    print $/."For more information, please refer to https://en.wikipedia.org/wiki/Ranking".$/;
    exit 1;
}

sub load_data {
    open(my $fh, "<", '../ch2-data.csv') or die "Could not open ch2-data.csv': $!";
    my %data;
    while( my $line = <$fh> ) {
        chomp $line;
        my ($time,$name) = split /;/, $line;
        push @{$data{$time}}, $name;
    }
    close $fh;
    return %data;
}
