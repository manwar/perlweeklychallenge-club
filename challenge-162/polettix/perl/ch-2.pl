#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say encrypt('playfair example', 'hide the gold in the tree stump');
say decrypt('perl and raku', 'siderwrdulfipaarkcrw');

sub encrypt ($key, $message) { wheatstone_playfair($key, $message, 1) }
sub decrypt ($key, $message) { wheatstone_playfair($key, $message, 5 - 1) }
The main workhorse is then the following function, I hope the comments are sufficient!

sub wheatstone_playfair ($key, $message, $off) {

   # pre-massage the input, go uppercase and remove all j:s
   $_ = lc($_) =~ s{j}{i}rgmxs for $key, $message;

   # we don't need no stinkin' matrix, a bijection in two arrays is OK
   my %flag;
   my @letter_at = grep { $flag{$_}++ == 0 }
     split(m{[^a-z]?}imxs, $key), 'a' .. 'i', 'k' .. 'z', 'j';

   # the "go back" might be a hash but we are C nostalgic
   my $oA = ord('a');          # used to turn lc letters into array indexes
   my @pos_of = map { $_->[0] }   # get indexes
     sort { $a->[1] cmp $b->[1] } # sorted by letter position
     map { [$_, $letter_at[$_]] } 0 .. $#letter_at;

   # take only letters into consideration, split on everything else
   my @message = split m{[^a-z]?}imxs, $message;
   my @output;
   while (@message) {

      # first letter is whatever, second letter might be an X
      my $A = shift @message;
      my $B = @message && $message[0] ne $A ? shift @message : 'x';

      # get positions, $A and $B are spoiled on the way but it's OK
      my ($Ax, $Ay, $Bx, $By) = map {
         my $v = $pos_of[ord($_) - $oA];
         ($v % 5, int($v / 5))
      } ($A, $B);

      # apply Wheatstone-Playfair mapping
      ($Ax, $Ay, $Bx, $By) =
          $Ax == $Bx ? ($Ax, ($Ay + $off) % 5, $Bx, ($By + $off) % 5)
        : $Ay == $By ? (($Ax + $off) % 5, $Ay, ($Bx + $off) % 5, $By)
        :              ($Bx, $Ay, $Ax, $By);

      push @output, @letter_at[$Ax + 5 * $Ay, $Bx + 5 * $By];
   } ## end while (@message)
   return join '', @output;
} ## end sub wheatstone_playfair
