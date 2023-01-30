#! /usr/bin/perl
#  caesar-cipher.pl
use v5.30;
sub error;
error and exit 666 if @ARGV != 1;
my $N = shift @ARGV;
error and exit 666 if $N !~ /^-?\d+$/;
error and exit 666 if $N < -26 || $N > 26;
my @upper   = split //,'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
my @lower   = split //,'abcdefghijklmnopqrstuvwxyz';
my @strings = <>;
say '';
foreach my $S (@strings)
{
   foreach my $index (0..((length $S)-1))
   {
      my $ord = ord(substr($S,$index,1));
      if ($ord >= 65 && $ord <= 90)
         {substr($S,$index,1) = $upper[($ord-65-$N)%26];}
      if ($ord >= 97 && $ord <= 122)
         {substr($S,$index,1) = $lower[($ord-97-$N)%26];}
   }
   print $S;
}
exit 0;
sub error
{
   print ((<<'   END_OF_ERROR') =~ s/^   //gmr);
   Input Error: \"caesar-cipher.pl\" requires exactly 1 command-line
   argument, which must be a positive integer in the closed interval
   [-26,26]. This will be used as a "rotate" value for performing a
   "Caesar Cipher" on the input. Positive values will perform a left
   rotate and Negative values will perform a right rotate.
   
   The input should be a string (or a series of strings) containing
   English letters (and perhaps some other characters). The letters
   will be alphabetically "rotated" to different letters and the other
   characters will be passed through unchanged.
   
   The input must be fed to this program through stdin,
   either from a file redirect:

      $ caesar-cipher.pl 17 < myfile.txt

   or via a pipe:

      $ echo 'Sullenly, sadly, silently he walked home.' | caesar-cipher.pl 8

   or via the keyboard:

      $ caesar-cipher.pl 17
      Seventeen times she smote her foe with her axe,[Enter]
      but each time he withstood her savage blows.[Enter][Ctrl-D]

      Bnenwcnnw crvnb bqn bvxcn qna oxn frcq qna jgn,
      kdc njlq crvn qn frcqbcxxm qna bjejpn kuxfb.

   END_OF_ERROR
   return 1;
} # end sub error
