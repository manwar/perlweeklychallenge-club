#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use Algorithm::Combinatorics 'permutations';
use List::Util 'uniq';
use Getopt::Long;

my $verbose      = 0; GetOptions("verbose" => \$verbose);

my $string       = shift(@ARGV) || 'PERL';
my $permutations = shift(@ARGV) || "PELR PREL PERL PRLE PLER PLRE EPRL EPLR ERPL
                                    ERLP ELPR ELRP RPEL RPLE REPL RELP RLPE RLEP
                                    LPER LPRE LEPR LRPE LREP";

my @letters      = split("", $string);
my %permuations  = map { $_ => 1} split(/\s+/, $permutations);

my @missing;

for my $candidate (permutations(\@letters))
{
  my $as_string = join("", @$candidate);
  say ": Checking candidate: $as_string" if $verbose;
  push(@missing, $as_string) unless $permuations{$as_string};
}

say join(", ", uniq @missing) if @missing;
