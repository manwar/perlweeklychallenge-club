#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub jump_game ($N) {
   my $position = 0;
   $position += $N->[$position] while $position < $#$N && $N->[$position];
   return $position == $#$N ? 1 : 0;
}

my @sequence = @ARGV ? @ARGV : (1, 2, 1, 2);
say jump_game(\@sequence);
