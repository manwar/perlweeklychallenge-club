#!/usr/bin/env perl

###########################################################################
# script name: ch-1.pl                                                    #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-047/         #
#                                                                         #
# Write a script that accepts two roman numbers and operation. It should  #
# then perform the operation on the give roman numbers and print the      #
# result.                                                                 #
#                                                                         #
# e.g.                                                                    #
#         ch-1.pl V + VI                                                  #
#                                                                         #
# output:                                                                 #
#         XI                                                              #
#                                                                         #
###########################################################################

use strict;
use warnings;

use FindBin;
use Roman;

my $argString = uc "@ARGV";
my $script    = $FindBin::Script;

die "$FindBin::Script requires arguments.\n" if scalar @ARGV == 0;

print STDERR "[Arabic number detected in input]\n" if $argString =~ m{\d+};

$argString =~ s{(\s*[-+*/%]\s*)}{ $1 }g;
$argString =~ s{([MDCLXVI]+)}{arabic $1}ge;

my $result = eval $argString;

my $oldResult = $result;
$result = int $result;
my $decimal = $oldResult - $result;
print STDERR "Calculation result had a decimal $decimal that was truncated.\n" if $decimal;

if ( $result == 0) {
    print "N (no formal zero)\n"; # https://en.wikipedia.org/wiki/Roman_numerals#Zero
} elsif ($result > 3_999) {
    die "Calculation result $result exceeds MMMCMXCIX (3,999) the maximum value of the Roman number format.\n";
} elsif ($result < 0) {
    die "Calculation result $result is negative. Roman numbers are positive integers.\n";
} else {
    $result = Roman(int $result);
    print "$result\n";
}
