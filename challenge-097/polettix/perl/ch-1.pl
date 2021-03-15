#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub caesar_cipher ($S, $N) {
   $N %= 26;
   my $to   = join '', 'A' .. 'Z';
   my $from = substr($to, $N) . substr($to, 0, $N);
   return eval "\$S =~ tr/$from/$to/r";
}

my $input = shift || 'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG';
my $n = shift || 3;
say $input;
say caesar_cipher($input, $n);
