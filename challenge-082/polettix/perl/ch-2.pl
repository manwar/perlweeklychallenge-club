#!/usr/bin/env perl
use 5.024;
use warnings;
use English qw< -no_match_vars >;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

# well... let's recurse!
sub iir ($A, $B, $C) {
   return 1 if (length($A) == 0 && $B eq $C)  # only B remained
      || (length($B) == 0 && $A eq $C)        # only A remained
      || (length($C) == 0);                   # never reached, paranoia
   my $cc = substr $C, 0, 1, ''; # chop off first char from $C...
   return (($cc eq substr $A, 0, 1) && iir(substr($A, 1), $B, $C))
       || (($cc eq substr $B, 0, 1) && iir(substr($B, 1), $A, $C));
}

sub is_interleaving ($A, $B, $C) {
   return (length($A) + length($B) == length($C)) && iir($A, $B, $C);
}

my $A = shift || 'XY';
my $B = shift || 'Z';
my $C = shift || 'ZXY';
say is_interleaving($A, $B, $C);
