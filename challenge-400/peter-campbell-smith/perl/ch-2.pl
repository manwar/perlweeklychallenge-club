#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/400/2

use v5.26;    # The Weekly Challenge - 2026-11-16
use utf8;     # Week 400 - task 2 - Minimum genetic mutation
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

minimum_genetic_mutation('AACCGGTT', 'AACCGGTA', 
	["AACCGCTA", "AAACGGTA"]);
minimum_genetic_mutation('AACCGGTT', 'AACCGGAA', 
	["AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA"]);
minimum_genetic_mutation('AAAAAAAA', 'AAAAACCC', 
	["CAAAAAAA", "CCAAAAAA", "AAAAAAAC"]);
minimum_genetic_mutation('GAAAAAAA', 'GCCCCCCC', 
	["GCAAAAAA", "GCCAAAAA", "GCCCAAAA", "GCCCCAAA", "GCCCCCAA", 
	"GCCCCCCA", "GCCCCCCC"]);
minimum_genetic_mutation('AACCGGTT', 'AACCGGTT', ["AACCGGTA"]);

sub minimum_genetic_mutation {

	my ($c, $changed, $changes, $done, $end, $from, $i, $j, $k, 
		$length, $min_muts, $mut_path, $muts, $new_p, $p, $start, 
		$to, $win, %from, @bank, @links, @new_paths, @paths, @to);
	
	# initialise
	$start = $_[0];
	$end = $_[1];
	@bank = @{$_[2]};
	$length = length($start);
	say qq[\nInput:  \$start = '$start', \$end = '$end',]; 
	say qq[        \@bank = ('] . join(q[', '], @bank) . q[')];
	@bank = ($start, @bank, $end);
	if ($start eq $end) 
		{ say qq[Output: 0 - no mutation needed]; return }
		
	# find all mutations (transitions where 1 char changes)
	for $i (0 .. $#bank - 1) {
		$from{$i} = '';
		for $j ($i + 1 .. $#bank) {
			$changes = 0;
			for $k (0 .. $length - 1) {
				$changes ++ if substr($bank[$i], $k, 1)
							ne substr($bank[$j], $k, 1);
			}
			if ($changes == 1) {
				push @links, qq[$i,$j];
				push @links, qq[$j,$i] if $i != 0 and $j ne $#bank;
			}
		}
	}
	
	# loop over no of mutations (cannot exceed length of bank + 1)
	@paths = ('!0!');
	$p = 0;
	for $i (0 .. $#bank) {
		
		# loop over mutation paths
		for $j (0 .. $#paths) {
			$paths[$j] =~ m|!(\d+)!$|;
			$end = $1;
			
			# increment path
			K: for $k (0 .. $#links) {
				$links[$k] =~ m|(\d+),(\d+)|;
				($from, $to) = ($1, $2);
				next unless $from == $end;
				next if $paths[$j] =~ m|!$to!|;
				$new_p = $paths[$j] . qq[!$to!];
				for $p (@new_paths) {
					next K if $p eq $new_p;
				}
				$new_paths[$p++] .= $new_p;
			}
		}
		
		# update paths and repeat
		@paths = @new_paths;
	}
	
	# find solution and format output
	$min_muts = 1e6;
	$end = $#bank;
	for $j (0 .. $#paths) {
		next unless $paths[$j] =~ m|!$end!$|;
		$muts = () = $paths[$j] =~ m|!!|g;
		if ($muts < $min_muts) {
			$min_muts = $muts;
			while ($paths[$j] =~ m|!(\d+)!|g) {
				$mut_path .= qq['$bank[$1]', ];
			}
			$win = $paths[$j];
		}
	}
	if ($min_muts == 1e6) { say qq[Output: -1 - impossible]; return }
	say qq[Output: minimum mutations = $min_muts : ] . 
		substr($mut_path, 0, -2);	
}

