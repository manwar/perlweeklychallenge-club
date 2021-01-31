#! /usr/bin/perl
#  binary-substrings.pl
use v5.30;
sub error;
error and exit 666 if @ARGV != 2;
my $B = shift @ARGV;
my $S = shift @ARGV;
error and exit 666 if $B !~ /^[01]{2,}$/;
error and exit 666 if $S !~ /^[1-9]\d*$/;
my $L = length $B;
error and exit 666 if 0 != $L % $S;
say "\$B = $B  \$S = $S";
my @substrs;
foreach my $group ( 0 .. $L/$S - 1 )
{
   push @substrs, substr($B, $S*$group, $S);
}
say "Consecutive $S-element substrings of $B:";
say for @substrs;
my @flips;
foreach my $index ( 0 .. $L/$S - 1 )
{
   foreach my $group ( 0 .. $L/$S - 1 )
   {
      next if $group == $index;
      foreach my $digit ( 0 .. $S - 1 )
      {
         ++$flips[$index] if substr($substrs[$group], $digit, 1) 
                          != substr($substrs[$index], $digit, 1);
      }
   }
}
my $best_idx = 0;
my $best_fls = 1987654321;
foreach my $index ( 0 .. $L/$S - 1 )
{
   if ($flips[$index] < $best_fls)
      {$best_fls = $flips[$index]; $best_idx = $index;}
}

say "Lowest number of flips to equalize substrings = $best_fls,";
say "achieved by using substring index $best_idx ($substrs[$best_idx])";
say "as a \"paragon\" and flipping all other substrings to match it.";

exit 0;
sub error
{
   my $NA = shift;
   print ((<<'   END_OF_ERROR') =~ s/^   //gmr);
   Input Error. "binary-substrings.pl" requires exactly 2 arguments.
   The first argument ("$B") must be a binary-number string at least 2 digits
   long with a non-prime number of digits. The second argument ("$S") must be
   a positive integer which is a factor of the length of the binary-number
   string. This program will then print the consecutive $S-long substrings of
   $B, and show the minimum number of digit flips to make all of the substrings
   identical to the first.
   END_OF_ERROR
   return 1;
} # end sub error_msg ($)
