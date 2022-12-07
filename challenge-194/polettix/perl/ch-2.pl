#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

@ARGV = qw< abbc xyzyyxz xzxz > unless @ARGV;
say frequency_equalizer($_) . " -> $_" for @ARGV;

sub frequency_equalizer ($string) {
   my (%first_counter, %second_counter);
   ++$first_counter{substr($string, $_, 1)} for 0 .. length($string) - 1;
   ++$second_counter{$_} for values %first_counter;
   return 0 if scalar(keys %second_counter) != 2;
   my ($k1, $v1, $k2, $v2) = %second_counter;
   ($k1, $v1, $k2, $v2) = ($k2, $v2, $k1, $v1) if $k1 > $k2;
   return 1 if $v2 == 1 && $k2 - $k1 == 1;
   return 0;
}
