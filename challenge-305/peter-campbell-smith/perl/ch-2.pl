#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-01-20
use utf8;     # Week 305 - task 2 - Alien dictionary
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

alien_dictionary(['perl', 'python', 'raku'],
       [qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/]);
alien_dictionary(['the', 'weekly', 'challenge'],
       [qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/]);
alien_dictionary(['aarvark', 'antelope', 'deer', 'hyrax', 'meercat',  'sloth', 'tiger', 'unicorn', 'zebra'],
       [qw/z y x w v u t s r q p o n m l k j i h g f e d c b a/]);

sub alien_dictionary {
	
	my (@words, @alien, %from_alien, %to_alien, $j, $w, @letters);
	
	@words = @{$_[0]};
	@alien = @{$_[1]};
	say qq[\nInput:  \@words = ('] . join(q[', '], @words) . q[')];
	say qq[        \@alien = qw/] . join(' ', @alien) . '/';
	
	# make translation tables
	for $j (0 .. 25) {
		$to_alien{$alien[$j]} = chr(ord('a') + $j); 
		$from_alien{chr(ord('a') + $j)} = $alien[$j];
	}
	
	# translate each word to Alienese
	for $w (0 .. $#words) {
		@letters = split('', $words[$w]);
		$letters[$_] = $to_alien{$letters[$_]} for 0 .. $#letters;
		$words[$w] = join('', @letters);
	}
	
	# sort words
	@words = sort @words;
	
	# translate each word to English
	for $w (0 .. $#words) {
		@letters = split('', $words[$w]);
		$letters[$_] = $from_alien{$letters[$_]}  for 0 .. $#letters;;
		$words[$w] = join('', @letters);
	}	

	say qq[Output: \@words = ('] . join(q[', '], @words) . q[')];
}
