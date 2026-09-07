#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/389/1

use v5.26;    # The Weekly Challenge - 2026-08-31
use utf8;     # Week 389 - task 1 - Reorder notes
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

reorder_notes('Bach', [qw(C D E F♯ G A B)], 
	[7, 1, 6, 2, 5, 3, 4]);
reorder_notes('Beethoven', [qw(C D F♯ G A♭)], 
	[1, 3, 5, 2, 4]);
reorder_notes('Brahms', [qw(C D♭ E♭ F G A♭ B♭ C D)], 
	[9, 3, 7, 1, 8, 5, 2, 6, 4]);
reorder_notes('Bruckner', [qw(G F♯ B♭ C D E♭ F)], 
	[4, 7, 2, 6, 1, 5, 3]);
reorder_notes('Berg', [qw(C♯)], [1]);
reorder_notes('Mozart', [qw(G B♭ C A D C♯ D)], 
	[7, 6, 5, 4, 3, 2, 1]);

sub reorder_notes {
	
	my ($composer, @notes, @sequence, @tune, $i);
	
	# initialise
	$composer = $_[0];
	@notes = @{$_[1]};
	@sequence = @{$_[2]};
	
	# rearrange notes
	$i = 0;
	do {
		$tune[$sequence[$i] - 1] = $notes[$i];
		$i ++;
	} until ($i == @notes);
		
	# report
	say qq[\nInput:  \$composer = $composer];
	say qq[        \@notes    = ] . join(', ', @notes); 
	say qq[        \@sequence = ] . join(', ', @sequence);
	say qq[Output: ] . uc($composer) . qq[ => ] . join (' ', @tune);
}

