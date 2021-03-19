#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

$|++;

sub input ($description, @allowed) {
   my $input;
   while (! (defined($input) && grep { $input eq $_ } @allowed)) {
      say $description;
      print {*STDOUT} 'your choice > ';
      chomp($input = <STDIN>);
   }
   return $input;
}

sub nim_game {
   my $player = input(<<'END', 0, 1);
Which player should start?
0. me (computer)
1. you (human)
END

   my $tokens = 12;
   while ($tokens > 0) {
      my $grab;
      if ($player) {
         $grab = input(<<'END', 1, 2, 3);
How many tokens do you want to take? (1, 2, or 3)
END
      }
      else {
         $grab = $tokens % 4 || 1 + int(rand 3);
         say "I take $grab", $grab == 1 ? ' token' : ' tokens';
      }
      $tokens -= $grab;
      say $tokens, ($tokens == 1 ? ' token ' : ' tokens '), 'left';
      $player = 1 - $player;
   }

   say $player ? 'I win!' : 'You win!';
}

nim_game();
