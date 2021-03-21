#! /usr/bin/env raku

unit sub MAIN;

my $tokens = 12;

loop
{
  say "Remaining tokens: $tokens";
  
  my $count = prompt "How many tokens do you want (1,2,3): ";

  die unless $count == any(1,2,3);

  $tokens -= $count;

  if $tokens <= 0
  {
    say "You won!";
    last;
  }

  say "Remaining tokens: $tokens";

  $count = $tokens <= 3 ?? $tokens !! (1,2,3).pick;
  say "Machine picked $count tokens";
  $tokens -= $count;

  if $tokens <= 0
  {
    say "The Machine won!";
    last;
  }
}
