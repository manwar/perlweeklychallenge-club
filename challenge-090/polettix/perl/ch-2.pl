#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub ethiopian_multiplication ($A, $B) {
   say {*STDOUT} "# Let's multiply A = $A and B = $B, the Ethiopian way!";

   my $p = sub { printf {*STDOUT} "A = %3d, B = %3d%s\n", $A, $B, ($A % 2 ? '   (*)' : '') };
   $p->();
   say {*STDOUT} '';

   my $result_string = "A * B = $A * $B";

   if ($A == 1 || $B == 1) {
      say {*STDOUT} "$result_string = ", $A * $B, ' no need for Ethiopians!';
      return;
   }

   my $A_starts_even = $A % 2 == 0;
   if ($A_starts_even) {
      say {*STDOUT} '# Let\'s transfer all the even-ness from A to B';
      while ($A % 2 == 0) {
         $A /= 2;
         $B *= 2;
         $p->();
      }
      say {*STDOUT} '';
   }

   my $sum = $B;
   if ($A > 1) {
      print {*STDOUT} $A_starts_even ? '# Now ' : '# ';
      say {*STDOUT} 'A is odd, but we will ignore remainders for now...';
      while ($A > 1) {
         $A = int($A / 2);
         $B *= 2;
         $sum += $B;
         $p->();
      }
      say {*STDOUT} '';
   }

   say {*STDOUT} '# Now, we take all "B" values marked with an asterisk';
   say {*STDOUT} "$result_string = $sum";

   return;
}

my $A = shift || 14;
my $B = shift || 12;
ethiopian_multiplication($A, $B);
