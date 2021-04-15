#!/usr/bin/env raku

sub locate-memory ( \a ) {
    a.WHERE
}


multi MAIN (Bool :$test!) {
   use Test;

   my $a =  2;
   my $c = $a;
   my $b = 3;
   is locate-memory($a), $c.WHERE;
   is locate-memory($a), locate-memory($c);
   is locate-memory($b), locate-memory(3);

   my @d := (1,2);
   my @e := @d;
   my @f = @d;
   is locate-memory(@d), locate-memory(@e);
   isnt locate-memory(@d), locate-memory((1,2));
   isnt locate-memory(@d), locate-memory(@f);

   done-testing;;
}
