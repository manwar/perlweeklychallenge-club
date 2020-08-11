#!/usr/bin/perl

use feature 'say';
use strict;
use warnings;

$/=undef;
my %T;
while(<>) {
  $T{'a'} += y/aA/aA/;
  $T{'b'} += y/bB/bB/;
  $T{'c'} += y/cC/cC/;
  $T{'d'} += y/dD/dD/;
  $T{'e'} += y/eE/eE/;
  $T{'f'} += y/fF/fF/;
  $T{'g'} += y/gG/gG/;
  $T{'h'} += y/hH/hH/;
  $T{'i'} += y/iI/iI/;
  $T{'j'} += y/jJ/jJ/;
  $T{'k'} += y/kK/kK/;
  $T{'l'} += y/lL/lL/;
  $T{'m'} += y/mM/mM/;
  $T{'n'} += y/nN/nN/;
  $T{'o'} += y/oO/oO/;
  $T{'p'} += y/pP/pP/;
  $T{'q'} += y/qQ/qQ/;
  $T{'r'} += y/rR/rR/;
  $T{'s'} += y/sS/sS/;
  $T{'t'} += y/tT/tT/;
  $T{'u'} += y/uU/uU/;
  $T{'v'} += y/vV/vV/;
  $T{'w'} += y/wW/wW/;
  $T{'x'} += y/xX/xX/;
  $T{'y'} += y/yY/yY/;
  $T{'z'} += y/zZ/zZ/;
}


say $_,': ',$T{$_}||0 foreach 'a'..'z';
