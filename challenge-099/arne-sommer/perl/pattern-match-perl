#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use Getopt::Long;

my $verbose = 0;

GetOptions("verbose" => \$verbose);

my $S = shift(@ARGV);
my $P = shift(@ARGV);

die '"$S" must have length' unless length $S;
die '"$P" must have length' unless length $P;

$P =~ s/\*/.*/g;
$P =~ s/\?/./g;

say ": Perl Regex: $P " if $verbose;

say $S =~ /^$P$/ ? 1 : 0;
