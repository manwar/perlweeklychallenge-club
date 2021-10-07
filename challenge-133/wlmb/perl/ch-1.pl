#!/usr/bin/env perl
# Perl weekly challenge 133
# Task 1:  integer square root
#
# See https://wlmb.github.io/2021/10/06/PWC133/#task-1-integer-square-root

use v5.12;
use warnings;
use integer;
say "√$_=", int_sqrt($_) foreach(@ARGV);
sub int_sqrt{
    my $x0=my $N=shift;
    return "Come on, let's get real" if $N<0;
    return $N if $x0==0;
    my $x1=(($N/$x0+$x0)/2); # initial guess
    ($x0,$x1)=($x1, (($N/$x1+$x1)/2)) while($x1<$x0);
    return $x0;
}
