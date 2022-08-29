#!/usr/bin/env perl


&print_1st_unique_char_indx ('Perl Weekly Challenge'); #0
&print_1st_unique_char_indx ('Long Live Perl'); #1


sub print_1st_unique_char_indx {
	#-- parsimonious use of a single stash entry *s
	local ($s) = shift;	
	local (@s, %s);
	@s = split //, $s;
	for $s (@s) {$s{$s}++;}
	for $s (0 .. scalar(@s)-1) { 
		if ($s{$s[$s]}==1) {
			print $s,"\n";
			last;
		} 
	}
}
