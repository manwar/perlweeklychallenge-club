#!/usr/bin/env perl
use v5.24;
use strict;
use warnings;
use autodie;

#
# Copyright (C) 2019 Joelle Maslak
# All Rights Reserved - See License
#

#
# Source file contains lines in the following format:
#
#   <score><tab><description>
#
# So, for instance:
#   32  Foo
#   40  Bar
#   40  Baz
#   66  Quux
#   67  Quuux
#   67  Quuuux
#
# There should be no tabs other than the single tab seperating score
# from description.
#
# Scores are assumed to be integers that can be printed with %5d.

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

die("Only one argument may be supplied - file to read") if scalar(@ARGV) >= 2;
my $srcfile = $ARGV[0] // 'ch-2.txt';

my ( @lines, %bag );
open my $fh, '<', $srcfile;
while ( my $line = <$fh> ) {
    chomp $line;

    my $pair = [ split /\t/, $line ];
    push @lines, $pair;
    $bag{ $pair->[0] }++;
}

@lines = reverse
  sort { ( $a->[0] <=> $b->[0] ) or ( $b->[1] cmp $a->[1] ) } @lines;

say "  STD   MOD DENSE SCORE DESCRIPTION";

my $standard = 0;
my $modified = 0;
my $dense    = 0;
my $lastscore;
for my $pair (@lines) {
    my $score = $pair->[0];
    my $desc  = $pair->[1];

    if ( ( !defined($lastscore) ) or ( $lastscore != $score ) ) {
        $standard += defined($lastscore) ? $bag{$lastscore} : 1;
        $modified += $bag{$score};
        $dense++;
        $lastscore = $score;
    }

    printf( "%5d %5d %5d %5d %s\n", $standard, $modified, $dense, $score, $desc );
}

