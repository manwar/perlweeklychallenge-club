#!/usr/bin/env perl6
# Pythagoras pie puzzle

sub s ($j) { $j > 0 ?? r($j-1)*($j / 100) !!   0 };                 #  Mutually recursive share and remainder functions;
sub r ($k) { $k > 0 ?? r($k-1) - s($k)    !! 100 };                 #  $j and $k represent guest numbers

my @as = 0, { state $j=0; s(++$j) } ... *;                          #  Memory for calculated values, just to speed
my @ar = 0, { state $k=0; s(++$k) } ... *;                          #+ things up

my $i=1;                                                            # Guest number
my $m=0;                                                            # Guest number associated with biggest share

until @ar[$i-1] < @as[$m] { if @as[$i] > @as[$m] { $m=$i }; $i++ };
printf "Guest $m takes the biggest piece: %.2f%% of the cake.\n", s($m);
