#!/usr/bin/env perl
use strict;
use warnings;

use experimental 'smartmatch';

my $spaces = 3;
my $segment_lenght = 7;

print "Please enter a decimal number: ";
my $input = <STDIN>;
chomp $input;
die 'input not valid'
    unless $input =~ /^\d+$/;
my @digits = split //, $input;

my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;

foreach my $step (0..6) {
    foreach my $i (0..$#digits) {
        my $segments = $truth[$digits[$i]];
        if ($step ~~ [0]) {
            horizontal_line(($segments =~ /a/) ? 1 : 0);
            spaces_or_newline($i, $#digits);
        }
        if ($step ~~ [1..2]) {
            vertical_line(($segments =~ /f/) ? 1 : 0);
            spaces_between_segments();
            vertical_line(($segments =~ /b/) ? 1 : 0);
            spaces_or_newline($i, $#digits);
        }
        if ($step == 3) {
            horizontal_line(($segments =~ /g/) ? 1 : 0);
            spaces_or_newline($i, $#digits);
        }
        if ($step ~~ [4..5]) {
            vertical_line(($segments =~ /e/) ? 1 : 0);
            spaces_between_segments();
            vertical_line(($segments =~ /c/) ? 1 : 0);
            spaces_or_newline($i, $#digits);
        }
        if ($step == 6) {
            horizontal_line(($segments =~ /d/) ? 1 : 0);
            spaces_or_newline($i, $#digits);
        }
    }
}

sub spaces_or_newline {
    my ($i, $digits) = @_;
    if ($i < $digits) {
        print ' 'x$spaces;
    } else {
        print "\n";
    }
}

sub horizontal_line {
    if ($_[0]) {
        print '-'x$segment_lenght;
    } else {
        print ' 'x$segment_lenght;
    }
}

sub vertical_line {
    if ($_[0]) {
        print '|';
    } else {
        print ' ';
    }
}

sub spaces_between_segments {
    print ' 'x($segment_lenght-2);
}
