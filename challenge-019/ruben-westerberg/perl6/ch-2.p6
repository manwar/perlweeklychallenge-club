#!/usr/bin/env perl6
sub MAIN(:$col=80) {
	my @words=$*IN.lines.split(" ",:v);
	while @words {
		state $rem=$col;
		my $w=@words[0];

		if $w.chars > $col {
			print $w,"\n";
			@words.shift;
			@words.shift;
			next;
		}
		if $w.chars <= $rem {
			print $w;
			$rem-=$w.chars;
			@words.shift;
		}

		else {
			print "\n";
			@words.shift if  @words[0] eq " ";
			$rem=$col;
		}
	}
}
