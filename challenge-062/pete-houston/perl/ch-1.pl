#!/usr/bin/env perl
#===============================================================================
#
#        FILE: 6201.pl
#
#       USAGE: ./6201.pl [-u] [ file ] [ file ] [ ... ]
#
# DESCRIPTION: Return a list of emails sorted by domain and then by
#              user part. Input is from filenames on the command line
#              or as a list of addrs on STDIN otherwise.
#
#     OPTIONS: -u to remove duplicates
#REQUIREMENTS: Getopt::Std, Path::Tiny, List::MoreUtils
#      AUTHOR: Pete Houston
#ORGANIZATION: Openstrike
#     VERSION: 1.0
#     CREATED: 26/05/20 21:02:43
#===============================================================================

use strict;
use warnings;

use Getopt::Std 'getopts';
use Path::Tiny 'path';
use List::MoreUtils 'uniq';

my $opts = {};
getopts ('u', $opts);
my $uniq = $opts->{u};

my @addrs;

if (@ARGV) {
    push @addrs, path ($_)->lines for @ARGV;
} else {
    push @addrs, <STDIN>;
}

my @sorted = map { "$_->[0]\@$_->[1]" }
    sort { $a->[1] cmp $b->[1] or $a->[0] cmp $b->[0] }
    map { my @x = split ('@', $_); [$x[0], lc $x[1]] } @addrs;
print $uniq ? uniq (@sorted) : @sorted;
