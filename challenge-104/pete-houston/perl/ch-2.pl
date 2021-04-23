#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 10402.pl
#
#        USAGE: ./10402.pl [ COUNT ]
#
#  DESCRIPTION: Play a game of Nim starting wth COUNT tokens. 
#
#      OPTIONS: If COUNT is not provided the default will be 12
# REQUIREMENTS: Lingua::EN::Inflexion
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 15/03/21
#===============================================================================

use strict;
use warnings;
use Lingua::EN::Inflexion;

print <<EOT;
Greetings, Professor Falken.
Shall we play a game?

Let's play Nim.
EOT

nim ($ARGV[0] || 12);

sub nim {
	my $bank = shift;

	# Choose who goes first
	my $player = int rand 2;
	print "Why don't " . noun ('she')->singular ($player + 1) .
		" go first this time?\n";

	# Loop until there are no tokens left
	while ($bank) {
		$bank -= $player ? opponent_pick ($bank) : my_pick ($bank);
		$player = ($player + 1) % 2;
	}

	# Last one to take tokens wins
	print noun ('She')->singular (2 - $player) . ' ' .
		verb ('is')->singular (2 - $player) .
		" the winner.\n";
}

sub opponent_pick {
	my $avail = shift;
	my $max = $avail < 3 ? $avail : 3;
	my $choice = 0;
	until ($choice <= $max and $choice > 0) {
		say_pot ($avail);
		print "Choose between 1 and $max: ";
		($choice) = <STDIN> =~ /([123])/;
		$choice //= 0; # These's always some kiddie to type in 'z'
		print "You chose $choice.\n";
	}
	return $choice;
}

sub my_pick {
	my $avail = shift;
	say_pot ($avail);
	my $choice = $avail % 4 || 1;
	print inflect ("I take <#:$choice> <N:tokens>.\n");
	return $choice;
}

sub say_pot {
	my $x = shift;
	print inflect ("\n<#d:$x>There <V:is> $x <N:token> in the pot.\n");	
}
