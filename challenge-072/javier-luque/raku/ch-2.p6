# Test: perl6 ch-2.p6
multi MAIN { MAIN(10,20) };
multi MAIN(Int $A, $B where $A > 1 && $B >= $A) {
	my $input_file = '/usr/share/dict/words';
	my $line_count = 0;

	for '/usr/share/dict/words'.IO.lines -> $line {
		$line_count++;
		say $line
			if ($line_count >= $A && $line_count <= $B);
	}
}
