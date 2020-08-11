#!/usr/bin/env perl
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-031/
#
#  Create a script to demonstrate creating dynamic variable name, assign a value to the variable and finally print the variable. The variable name would be passed as command line argument.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 10/27/2019 10:03:56 AM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw/say/;
use Test::More;

sub assing_variable {
    my $var_name = shift;
    no strict 'refs';

    # it works, but I would not like to debug it...
    ${$var_name} = "test";
    return 1;
}

my $name = $ARGV[0] or die 'Usage: ch-2.pl name';
assing_variable($name);

# TESTS

$name='bla';
assing_variable($name);

no strict 'refs';
is($$name,'test');

done_testing();

