#!/usr/bin/env raku

my %coins;
#= ("£1"=>1, "50p"=>0.5, "1p"=>0.01, "10p"=>0.1, "5p"=>0.05, "20p"=>0.2, "£2"=>2, "2p"=>0.02);

%coins{qw<£1 50p 1p 10p 5p 20p £2 2p>}=(1,0.5,0.01,0.1,0.05,0.2,2,0.02);
my @game= %coins.keys.pick: 8;

my @player;
my @computer;
my $computerTurnFlag=(True,False).pick;


put "NEW GAME";
put "Select left or right ends of list with the < or  > keys";
put "";
while @game {
	put @game;
	put "";
	my $pick;
	my $currentPlayer;
	if $computerTurnFlag {
		$pick=("<",">").pick;
		put "Computer picks $pick";
		$currentPlayer=@computer;
	}
	else {
		$currentPlayer=@player;
		while $pick=prompt "Select Left or right\n" {

			next if $pick eq none("<",">");
			last;
		}	
		put "Player picks $pick";
	}
	put "";
	my $val;
	$val=@game.pop if $pick eq ">";	
	$val=@game.shift if $pick eq "<";	
	$currentPlayer.push: $val;
	$computerTurnFlag=!$computerTurnFlag;	

}

my $playerTotal=%coins{@player}.sum;
my $computerTotal=%coins{@computer}.sum;

my $winner="DRAW";
$winner="PLAYER" if $playerTotal>$computerTotal;
$winner="COMPUTER" if $playerTotal < $computerTotal;
put "Player total: $playerTotal";
put "Computer Total: $computerTotal";
put "Winner is $winner";



