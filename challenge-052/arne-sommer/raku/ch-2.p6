#! /usr/bin/env raku

unit sub MAIN (:$verbose);

my $player's-turn = Bool.pick;

say ": The { $player's-turn ?? 'Player' !! 'Machine' } starts." if $verbose;

class coin
{
  has $.value;
  has $.label;

  method Str     { self.label }
  method Numeric { self.value }
  method Real    { self.value }
}

my @coins;

@coins.push: coin.new(label => "1p",  value =>   1);
@coins.push: coin.new(label => "2p",  value =>   2);
@coins.push: coin.new(label => "5p",  value =>   5);
@coins.push: coin.new(label => "10p", value =>  10);
@coins.push: coin.new(label => "20p", value =>  20);
@coins.push: coin.new(label => "50p", value =>  50);
@coins.push: coin.new(label => "£1",  value => 100);
@coins.push: coin.new(label => "£2",  value => 200);

@coins.=pick(*);

say ": Coins (val): { @coins>>.Numeric.join(", ") }" if $verbose;
say ": Coins (txt): { @coins>>.Str.join(", ") }"     if $verbose;

my $player   = 0;
my $computer = 0;

while @coins
{
  say "Available Coins: { @coins>>.Str.join(", ") }.";

  if $player's-turn
  {
    my $choice = @coins.elems > 1
      ?? prompt "Do you want the Left (L) or the Right (R): "
      !! "L";

    my $coin = $choice.substr(0,1) eq "L"
      ?? @coins.shift
      !! @coins.pop;

    say "You choose $coin";
    $player += $coin;
  }
  
  else # The computer has a go
  {
    my $coin = @coins[0] > @coins[*-1]
      ?? @coins.shift
      !! @coins.pop;
      
    say "The Computer choose $coin";
    $computer += $coin;
 }
  
  say "Player:   $player p";
  say "Computer: $computer p";
  say "";
  $player's-turn = ! $player's-turn
}

if    $player > $computer { say "Player won"; }
elsif $player < $computer { say "Computer won"; }
else                      { say "Nobody won"; }
