#!/usr/bin/env perl
# Perl weekly challenge 389
# Task 1:  Reorder Notes
#
# See https://wlmb.github.io/2026/08/31/PWC389/#task-1-reorder-notes
use v5.36;
use feature qw(try);
use List::Util qw(all);
die <<~"FIN" unless @ARGV and @ARGV%3==0;
    Usage: $0 C0 N0 P0 C1 N1 P1...
    to arrange the notes Ni of the composition by composer Ci
    applying the permutation Pi
    FIN

sub walk{
    my ($composer, $notes, $permutations, @rest) = @_;
    if($composer){
	    try {
		my @notes = split " ", $notes;
		my @permutations = split " ", $permutations;
		die "Number of notes should equal number of permutations"
		    unless @notes==@permutations;
		die "Index out of range" unless all {1<=$_<=@permutations} @permutations;
		say "$composer -> ",
		    join " ",
		    permute_notes([], [@notes], [@permutations])->@*;
	    }
	    catch($e){
		warn "${e}Composer=$composer, Notes=$notes, Permutation=$permutations";
	    }
	    walk(@rest);
    }
}

sub permute_notes($current, $notes, $permutations){
    if(@$notes){
	my $note=pop @$notes;
	my $place=pop @$permutations;
	die "Repeated destination: $place" if defined $current->[$place-1];
	$current->[$place-1]=$note;
	permute_notes($current, $notes, $permutations)
    }
    return $current;
}

walk(@ARGV);
