#!/usr/env perl
# Task 2 Challenge 052 Solution by saiftynet
# Lucky Winner
# Suppose there are following coins arranged on a table in a line 
# in random order.
# £1, 50p, 1p, 10p, 5p, 20p, £2, 2p
# Suppose you are playing against the computer. Player can only 
# pick one coin at a time from either ends. Find out the lucky winner, 
# who has the larger amounts in total?

# A game in which the user or the computer can pick from either
# end of an array...doing so implies either a pop or a shift. 
# This game offers player vs player, computer vs player or
# computer vs computer options, and best of multiple games
  
binmode STDOUT, 'utf8';  # required to allow £ symbol 

# initialise variables
my (@coins, @p1,@p2,$p1Total,$p2Total);          
my $p1wins=$p2Wins=0; 

# Select players human or computers, choose which goes first and number of
#ganmes to play
print "Enter name of player1, or blank for Computer :- " and chomp( my $player1=<>);
$player1="Computer" if $player1 eq "";
print "Enter name of player2, or blank for Computer :- " and chomp( my $player2=<>);
$player2="Computer" if $player2 eq "";

# if both players have same name (e.g if both are computers
if ($player1 eq $player2){$player1.=" 1"; $player2.=" 2"; };
print "Enter number of games (1-9)" and chomp( my $games=<>);
$games=1 if $games !~/^[1-9]$/;

# game loop
foreach (1..$games){
  print "\n\n### Starting game $_ ###\n";
  @p1=@p2=();$p1Total=$p2Total=0; 
  @coins=fisheryates(qw{1p 2p 5p 10p 20p 50p £1 £2}); # shuffle coins
  while (@coins>0){                                   # make moves until no more coins
    unshift @p1, move($player1)?shift @coins:pop @coins; # move coin from pile to  player
    print "---$player1 finds a $p1[0]\n";           # report coin found
    $p1Total+=coinValue($p1[0]);                    # add the value of the coin to player1s total
    unshift @p2,  move($player2)?shift @coins:pop @coins; # move coin from pile to  player
    print "---$player2 finds a $p2[0]\n";           # report coin found
    $p2Total+=coinValue($p2[0]);                    # add the value of the coin to player2s total
  }
  
  # game has ended, display reults
  print "\n$player1 has:  ", (join ", ",reverse @p1), " total= ",$p1Total;
  print "\n$player2 has:  ", (join ", ",reverse @p2), " total= ",$p2Total;
  if ($p1Total>$p2Total){
	  $p1wins++;
	  print "\n* $player1 wins!!";
	  next
  }
  $p2wins++;
  print "\n* $player2 wins!!";
  
}

# tot up overall results
print "\n* $player1 has won $p1wins games, $player2 has won $p2wins games";
sub move{
  my $mover=shift;
  my $choice="";
  if ($mover !~/Computer/){
    print "\n$mover pick end Left or Right (L or R)"  and  chomp($choice=<>) while $choice !~/[lr]/i;
  }
  else {
     ($choice=(rand()>.5)?"Left":"Right") and print "\n$mover picks $choice\n";
  }
	return $choice =~/l/i;
}

# a classic shuffling routine slightly modified from version in Perl Cookbook
# by Nathan Torkington, Tom Christiansen
sub fisheryates{
   my @list=@_;
   for ($i = @list; --$i; ){
      $j=rand($i+1);
      next if $i == $j;
      @list[$i,$j] = @list[$j,$i];
   }
return @list
}

# converts the coins to their penny values
sub coinValue{
  my $coin=shift;
  $coin=~s/p$//;             # if ends with p, just remove it
  $coin=~s/\£(\d)/$1*100/e;  # if starts with £, multiply by 100
  return $coin;
}
