#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-09-30
use utf8;     # Week 289 - task 2 - Jumbled letters
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

jumbled_letters(qq[The quick brown fox jumps over the lazy dog.]);
jumbled_letters(qq[The X-factor's inventor was Bloggs-Jones, who said 'Hello!']);
jumbled_letters(qq[Psychological Abstracts contains nonevaluative abstracts of literature in psychology and related disciplines, grouped into 22 major classification categories]);
jumbled_letters(qq[Deoxyribonucleic acid, mucopolysaccharides and propan-2-ol are organic chemicals.]);
jumbled_letters(qq[Das Mädchen möchte die Straẞe früh überqueren.]);
jumbled_letters(qq[L'accent circonflexe va disparaître des manuels scolaires à la rentrée: que s'est-il passé, et qu'en pense le ministre de l'Éducation nationale Najat Vallaud Belkacem?]);
jumbled_letters(qq[Η γρήγορη καφετιά αλεπού πηδά πάνω από το τεμπέλικο σκυλί]);
jumbled_letters(qq[Быстрая бурая лиса перепрыгивает через ленивую собаку.]);

sub jumbled_letters {
	
	my ($str, $before, $rest, $middle, $after, $one, $two, $x, $letters, $count, $length, $word, $lm, $s, $m, $jumbled);
	
	$str = $_[0] . ' ';
	$jumbled = '';
	
	# loop over 'words'
	while ($str =~ m|([^\s]*)\s+|gi) {
		
		# split word into $before, $middle and $after
		$word = $1;
		if ($word =~ m|\w| and length($word) >= 4) {
			($before, $rest) = $word =~ m|([^\w]*\w)(.*)|; 
			($middle, $after) = $rest =~ m|(.*?)(\w[^\w]*)$|;

			# put just the letters (\w) into letters
			$lm = length($middle);						
			$letters = $middle;
			$letters =~ s|[^\w]||g;
			$count = length($letters);
			
			# swap letters around randomly lots of times
			if ($count > 1) {
				for (0 .. $count + rand(7)) {
					do {
						$one = int(rand($count));
						$two = int(rand($count));
					} until $one != $two;
					$x = substr($letters, $one, 1);
					substr($letters, $one, 1) = substr($letters, $two, 1);
					substr($letters, $two, 1) = $x;
				}
				
				# now put the jumbled letters in place of the originals
				$s = 0;
				for $m (0 .. length($middle) - 1) {
					if (substr($middle, $m, 1) =~ m|\w|) {
						substr($middle, $m, 1) = substr($letters, $s ++, 1);
					}
				}
			}
			
			# reassemble the word
			$word = $before . $middle . $after;
		}
		
		# and add it to the jubled output
		$jumbled .= $word . ' ';
	}
	
	say qq[\nInput:  $str];
	say qq[Output: $jumbled];
}
