#!/usr/bin/env perl
# Perl weekly challenge 108
# Task 1: Locate Memory
#
# See https://wlmb.github.io/2021/04/12/PWC108/#task-1-locate-memory
use strict;
use warnings;
use v5.12;

use constant PI=>3.14;

sub X {}
my ($x, @x, %x);
our ($X, @X, %X);
my %map=('$x'=>\$x, '@x'=>\@x, '%x'=>\%x, '$X'=>\$X, '@X'=>\@X, '%X'=>\%X, '&X'=>\&X, 'PI'=>\&PI);
foreach (sort keys %map){
    my $r=$map{$_};
    $r=~/\((.*)\)/;
    say "$_=>$1";
}
