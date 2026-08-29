#Qperl
use strict;
use warnings FATAL => qw(all);

=prompt
A Dyck Word of order $n is a string of length 2x$n consisting of $n ‘U’ (Up) characters and $n ‘D’ (Down) characters such that no initial prefix of the string contains more ‘D’s than ‘U’s.

Write a script to return a list of all valid Dyck words of length 2x$n, sorted in lexicographical (alphabetical) order.
Example 1

Input: $n = 1
Output: ("UD")

Example 2

Input: $n = 2
Output: ("UDUD","UUDD")

Example 3

Input: $n = 3
Output: ("UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD")

Example 4

Input: $n = 0
Output: ("")

Example 5

Input: $n = 4
Output: ("UDUDUDUD", "UDUDUUDD", "UDUUDDUD", "UDUUDUDD", "UDUUUDDD",
         "UUDDUDUD", "UUDDUUDD", "UUDUDDUD", "UUDUDUDD", "UUDUUDDD",
         "UUUDDDUD", "UUUDDUDD", "UUUDUDDD", "UUUUDDDD")
=cut





use Test2::V0 -no_srand => 1;
is([dyck_words(1)], [("UD")], 'Example 1');
is([dyck_words(2)], [("UDUD","UUDD")], 'Example 2');
is([dyck_words(3)], [("UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD")], 'Example 3');
is([dyck_words(0)], [], 'Example 4');
is([dyck_words(4)], [("UDUDUDUD", "UDUDUUDD", "UDUUDDUD", "UDUUDUDD", "UDUUUDDD",
         "UUDDUDUD", "UUDDUUDD", "UUDUDDUD", "UUDUDUDD", "UUDUUDDD",
         "UUUDDDUD", "UUUDDUDD", "UUUDUDDD", "UUUUDDDD")], 'Example 5');
done_testing();

sub dyck_words
{
     my $n = $_[0];
     my @output;
     return @output if $n == 0;
     generator($n, $n, '', \@output);
     sub generator
     {
          my ($num_U, $num_D, $str, $aref) = @_;
          if ($num_U == 0 and $num_D == 0)
          {
               push @$aref, $str;
               return;
          }
          # first D then U for lexicographical order.
          if ( $num_D > $num_U )
          {
               generator($num_U, $num_D - 1, $str . 'D', $aref);
          }
          
          if ( $num_U > 0 )
          {
               generator($num_U - 1, $num_D, $str . 'U', $aref);
          }
          
     }
     return # sort { $a cmp $b } # is not necessary then.
     
          @output;
}
