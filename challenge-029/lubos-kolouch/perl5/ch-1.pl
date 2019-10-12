#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-029/
#
#  Write a script to demonstrate brace expansion. For example, script would
#  take command line argument Perl {Daily,Weekly,Monthly,Yearly} Challenge and
#  should expand it and print like below:
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 10/11/2019 03:56:17 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw/say/;
use Data::Dumper;
use Text::Glob::Expand;

sub expand_brace {
    my $words = shift;

    my $glob = Text::Glob::Expand->parse($words);
    my $permutations = $glob->explode_format("");

    return $permutations;

}
my ($words) = @ARGV;

my $permutations = &expand_brace($words);

say for keys %$permutations;

#-------- TEST ---------
use Test::More;

$permutations = &expand_brace('Perl {Daily,Weekly,Monthly,Yearly} Challenge');
is(keys %$permutations,4);


