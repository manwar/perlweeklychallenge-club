#!/usr/bin/env perl
use strict;
use warnings;
use List::Util;
my %coins;
@coins{qw<£1 50p 1p 10p 5p 20p £2 2p>}=(1,0.5,0.01,0.1,0.05,0.2,2,0.02);


my @game= pickSome([keys %coins], 8);
my @player;
my @computer;
my ($computerTurnFlag)=pickSome([0,1],1);


print "NEW GAME\n";
print "Select left or right ends of list with the < or  > keys\n\n";
while (@game) {
	print join ", ",@game;
	print "\n\n";
	my $pick;
	my $currentPlayer;
	if($computerTurnFlag) {
		($pick)=pickSome(["<",">"],1);
		print "Computer picks $pick\n";
		$currentPlayer=\@computer;
	}
	else {
		$currentPlayer=\@player;
		until ($pick) {

			print "Select Left or Right\n";
			$pick= <STDIN>;
			chomp $pick;
			if (($pick ne "<" )and( $pick ne ">")) {
				$pick=undef;
				next;
			}
			last;
		}	
		print "Player picks $pick\n";
	}
	print "\n";
	print "PICK IS $pick\n";
	my $val;
	$val=pop @game if $pick eq ">";	
	$val=shift @game if $pick eq "<";	
	push @$currentPlayer, $val;
	$computerTurnFlag++;
	$computerTurnFlag%=2;

}

my $playerTotal=List::Util::sum @coins{@player};
my $computerTotal=List::Util::sum @coins{@computer};

my $winner="DRAW";
$winner="PLAYER" if $playerTotal>$computerTotal;
$winner="COMPUTER" if $playerTotal < $computerTotal;
print "Player total: $playerTotal\n";
print "Computer Total: $computerTotal\n";
print "Winner is $winner\n";


sub pickSome {
	my ($in,$count)=@_;
	my @out;
	my @data=@$in;
	#	print "Data is: ",join ", ", @data;
	#print "\n";
	for (0..$count-1) {
		push @out,splice @data,int(rand(@data)),1;
	}
	#print "OUT is: ", join ", ", @out;
	#print "\n";
	@out;
}
