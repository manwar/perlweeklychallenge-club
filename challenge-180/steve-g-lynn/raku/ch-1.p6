#!/usr/bin/env perl6


&print_1st_unique_char_indx('Perl Weekly Challenge'); #0
&print_1st_unique_char_indx('Long Live Perl'); #1


sub print_1st_unique_char_indx ($s) {
	my @s = $s.comb;
	my %s;
	for (@s) {%s{$_}++;}
	for (0 .. @s.elems-1) -> $i { 
		if (%s{@s[$i]}==1) {
			say $i;
			last;
		} 
	}
}
