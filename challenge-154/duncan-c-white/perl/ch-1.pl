#!/usr/bin/perl
# 
# TASK #1 - Missing Permutation
# 
# You are given possible permutations of the string 'PERL'.
# 
# PELR, PREL, PERL, PRLE, PLER, PLRE, EPRL, EPLR, ERPL,
# ERLP, ELPR, ELRP, RPEL, RPLE, REPL, RELP, RLPE, RLEP,
# LPER, LPRE, LEPR, LRPE, LREP
# 
# Write a script to find any permutations missing from the list.
# 
# MY NOTES: should be easy, find all permutations and set subtract.
# Reuse my Perms module from challenge 149.  As a bonus, added the
# --baseword WORD flag to set the base word (default PERL).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
#use Data::Dumper;

use lib qw(.);
use Perms;

my $debug=0;
my $baseword = "PERL";
die "Usage: missing-perl-perms [--debug] [--baseword W] list(permutations_of_perl)\n"
	unless GetOptions( "debug"=>\$debug, "baseword=s" => \$baseword ) && @ARGV>1;
my %given = map { uc($_) => 1 } @ARGV;

# first perm has to be in lexicographic order
my $perm = join( '', sort split( //, $baseword ) );
say "first perm is $perm" if $debug;

my @missing;
do {
	say "perm=$perm" if $debug;
	push @missing, $perm unless $given{$perm};
	$perm = Perms::next_perm($perm);
} while defined $perm;

say "missing: ". join(',', @missing);
