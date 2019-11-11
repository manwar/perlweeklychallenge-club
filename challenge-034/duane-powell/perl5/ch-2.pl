#!/usr/bin/perl
use warnings;
use strict;
use feature qw( say );

# Write a program that demonstrates using hash slices and/or array slices.
# Write a program that demonstrates a dispatch table.

my @CARD; # Global deck of 52 playing cards
sub new_deck {
	@CARD = ();
	foreach my $suite ('H','S','C','D') {
		foreach my $rank ('2'..'9','T','J','Q','K','A') {
			my $card = $rank.$suite;
			push @CARD, $card;
		}
	}
	return "\nNew deck generated.";
}

sub shuffle_riffle {
	# riffle shuffe deck random between 100 and 500 times
	cut();
	my $loop = int(rand(501-100)+100); 
	foreach (1 .. $loop) {
		# split deck into left and right hand using array slices
		my @left  = @CARD[0  .. 25];           
		my @right = @CARD[26 .. 51];
		my @temp;
		foreach (1..26) {
			push @temp, shift @left;
			push @temp, shift @right;
		}
		@CARD = @temp;
	}
	return "Cards riffle shuffled $loop times.";
}

sub shuffle_reverse_cut {
	# Reverse cut shuffle using array slices between 1 and 10 times
	foreach (1 .. int(rand(10))+1) {
		cut();
		@CARD = (@CARD[40..51],@CARD[30..39],@CARD[20..29],@CARD[10..19],@CARD[0..9]);
	}
	return "Cards reverse cut shuffled.";
}

sub cut {
	# Don't cut deck perfectly, generated random number near middle of deck between 32 and 20
	my $rand = int(rand(33-20)+20);
	# Split deck into left and right hands using array slices
	my @left  = @CARD[0 .. $rand];           
	my @right = @CARD[$rand+1 .. 51];
	@CARD = (@right, @left);
	return "Cards cut.";
}

sub deal {
	my ($cards, $hands) = @_;
	foreach (1 .. $cards) { 
		foreach  (1 .. $hands) {
			my $card = shift @CARD;
			print "\t$card";
		}
		say "";
	}
	return "$hands hands of $cards cards dealt.";
}

sub deck_list {
	return "Remaining cards are: ". join(',',@CARD);
}

# Dispatch table
my %dispatcher = (
	'new_deck'            => \&new_deck,
	'shuffle_riffle'      => \&shuffle_riffle,
	'shuffle_reverse_cut' => \&shuffle_reverse_cut,
	'cut'                 => \&cut,
	'deal'                => \&deal,
	'deck_list'	      => \&deck_list,
);

# Call subs via dispatcher
say $dispatcher{'new_deck'}->();
foreach (1 .. int(rand(11-3)+3)) { # randomly call shuffle methods 3 to 10 times
	my $shuffle = (rand() < 0.5) ? "shuffle_riffle" :"shuffle_reverse_cut";
	say $dispatcher{$shuffle}->();
}
say $dispatcher{'cut'}->();
say $dispatcher{'deal'}->(5,5);
say $dispatcher{'deck_list'}->();

say $dispatcher{'new_deck'}->();
foreach (1 .. int(rand(11-3)+3)) { # randomly call shuffle methods 3 to 10 times
	my $shuffle = (rand() < 0.5) ? "shuffle_riffle" :"shuffle_reverse_cut";
	say $dispatcher{$shuffle}->();
}
say $dispatcher{'cut'}->();
say $dispatcher{'deal'}->(7,4);
say $dispatcher{'deck_list'}->();

__END__

./ch-1-and-2.pl

New deck generated.
Cards riffle shuffled 435 times.
Cards reverse cut shuffled.
Cards reverse cut shuffled.
Cards riffle shuffled 260 times.
Cards cut.
        JC      7C      6C      4D      KD
        QD      TD      9D      8C      3H
        AS      KS      9H      9C      7H
        KC      2D      KH      3S      6D
        7D      TC      TS      3C      3D
5 hands of 5 cards dealt.
Remaining cards are: AH,8H,8S,7S,JS,2S,4C,5C,JD,6S,QS,4H,4S,2C,TH,9S,5S,AC,QC,AD,5H,8D,5D,JH,QH,2H,6H

New deck generated.
Cards riffle shuffled 207 times.
Cards reverse cut shuffled.
Cards riffle shuffled 300 times.
Cards reverse cut shuffled.
Cards reverse cut shuffled.
Cards riffle shuffled 480 times.
Cards riffle shuffled 303 times.
Cards reverse cut shuffled.
Cards riffle shuffled 488 times.
Cards cut.
        4D      7S      3S      5D
        JH      9H      4H      6H
        KC      AS      8C      KS
        3C      5H      2D      TC
        3H      2H      6D      5S
        8S      AC      5C      KD
        8D      AH      9S      6S
4 hands of 7 cards dealt.
Remaining cards are: 2S,6C,TD,8H,7D,QD,7C,4C,AD,JS,9D,QH,TH,JD,JC,4S,QC,2C,QS,9C,3D,7H,KH,TS

