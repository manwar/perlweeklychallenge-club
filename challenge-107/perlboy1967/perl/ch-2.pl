#!/usr/bin/perl

# Perl Weekly Challenge - 107
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-107/#TASK2
#
# Task 2 - List Methods
#
# Author: Niels 'PerlBoy' van Dijke

BEGIN {
  use File::Basename qw(dirname);
  use lib dirname($0);
}

use v5.16;
use strict;
use warnings;

use CGI;

@ARGV = ('Calc')
  unless (scalar(@ARGV) > 0);

my ($lib, $evade) = @ARGV;

eval "use $lib";
die $@ if ($@);


if ($evade // 0) {
  # Sneak dynamically a new method in...
  eval sprintf q(sub %s::thatIsAllFolks { print "That\'s all folks!\n" }), $lib;
}

# Code taken from:
# https://stackoverflow.com/questions/910430/how-do-i-list-available-methods-on-a-given-object-or-package-in-perl

no strict 'refs';

printf "methods = ('%s')\n",  
       join("','", grep {defined &{"${lib}::$_"} } keys %{"${lib}::"});

if ($evade // 0) {
  &{"${lib}::thatIsAllFolks"}();
}

use strict 'refs';
