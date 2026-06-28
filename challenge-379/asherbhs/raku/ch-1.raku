sub reverse-string(Str:D $str --> Str:D) {
	my $chars = $str.comb;
	my $n = $chars - 1;
	$chars[$n «-« (0 .. $n)].join
}

say reverse-string '';
say reverse-string 'reverse the given string';
say reverse-string 'Perl is Awesome';
say reverse-string 'v1.0.0-Beta!';
say reverse-string 'racecar';
