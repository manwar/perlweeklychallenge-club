#!/usr/bin/env perl

###########################################################################
# script name: ch-2.pl                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-053/         #
#                                                                         #
# Vowel Strings                                                           #
#                                                                         #
# Write a script to accept an integer 1 <= N <= 5 that would print all    #
# possible strings of size N formed by using only vowels (a, e, i, o, u). #
# The string should follow the following rules:                           #
#                                                                         #
# 1. 'a' can only be followed by 'e' and 'i'.                             #
# 2. 'e' can only be followed by 'i'.                                     #
# 3. 'i' can only be followed by 'a', 'e', 'o', and 'u'.                  #
# 4. 'o' can only be followed by 'a' and 'u'.                             #
# 5. 'u' can only be followed by 'o' and 'e'.                             #
#                                                                         #
###########################################################################

use strict;
use warnings;
use diagnostics;

use FindBin;
use Math::Int2Base qw( int2base base2int );

my $num = 0;

if (! @ARGV) {
    print STDERR $FindBin::Script, " requires an argument. Argument should be 1 <= n <= 5\n";
    exit(1);
} else {
    $num = $ARGV[0];
}

if ($num < 1 or $num > 5) {
    print STDERR "Invalid choice. Argument should be 1 <= n <= 5\n";
    exit(1);
}

my @vowels = qw{ a e i o u };
my $MAX = '4' x $num;

my $j = 0;
for (my $i = 0; $j <= $MAX; ++$i) {
    $j = int2base($i,5);
    $j = sprintf "%0${num}d", $j;
    my $string;
    foreach (split(//,$j)){
        $string .= $vowels[$_];
    }
    if ( $string =~ m{a[^ei]}
        or $string =~ m{e[^i]}
        or $string =~ m{i[^aeou]}
        or $string =~ m{o[^au]}
        or $string =~ m{u[^oe]} ){
        next;
    } else {
        print "$string\n";
    }
}
