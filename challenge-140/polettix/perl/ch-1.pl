#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

package Bin;
use overload
   '+' => sub ($A, $B, @whatever) {
      my @A = split m{}mxs, $$A;
      my @B = split m{}mxs, $$B;
      my @result;
      my $carry = 0;
      while (@A || @B) {
         my $sum = $carry + (pop(@A) // 0) + (pop(@B) // 0);
         unshift @result, $sum & 0x01;
         $carry = $sum >> 1;
      }
      unshift @result, $carry if $carry;
      @result = (0) unless @result;
      return Bin->new(join '', @result);
   },
   '""' => sub ($x, @whatever) { '' . $$x };
sub new ($p, $x) { return bless \$x, $p }

package main;
sub Bin ($x) { return Bin->new($x) }

say Bin($ARGV[0] // 11) + Bin($ARGV[1] // 1);
