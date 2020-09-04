# Test: perl6 ch-2.p6

multi MAIN { MAIN("challenge.txt", "words.txt") };
multi MAIN(Str $letter_file, Str $word_file) {
	my @matrix = letters-to-matrix($letter_file);
	my %words  = dictionary-to-hash($word_file);
	my @answers;

	my $max_height = @matrix.elems;
	my $max_width  = @matrix.[0].elems;

	for (0 .. $max_height - 1) -> $i {
		for (0 .. $max_width - 1) -> $j {
			my @found =
				find-words(@matrix, %words, $i,
				          $j, $max_height, $max_width);
			@answers.push: @found
				if @found.elems;
		}
	}
	say "Found " ~  @answers.List.flat.elems ~ " words:";
	say @answers.List.flat.sort.join(", ");
}

sub find-words(@matrix, %words, $row, $col, $h, $w) {
	my @found;

	# Orthogonal directions with 1 on top
	# 1t 2tr 3r 4br 5b 6bl 7l 8tl
	for (1 .. 8) -> $x {
		my $i = $row;
		my $j = $col;
		my $possible_word = '';

		while ($i >= 0 && $j >=0 && $i < $h && $j < $w) {
			$possible_word ~= @matrix.[$i][$j].lc;

			@found.push($possible_word)
				if (%words{$possible_word});

			# Next position calculations
			$i-- if ($x == 1 || $x == 2 || $x == 8);
			$i++ if ($x == 4 || $x == 5 || $x == 6);
			$j-- if ($x == 6 || $x == 7 || $x == 8);
			$j++ if ($x == 2 || $x == 3 || $x == 4);
		}
	}

	return @found;
}


# Load the letters into a matrix
sub letters-to-matrix(Str $filename) {
	my @letter_matrix;

	for $filename.IO.lines -> $line {
		my @letters = $line.split(" ");
		@letter_matrix.push(@letters);
	}

	return @letter_matrix;
}

# Load the dictionary into memory
sub dictionary-to-hash(Str $filename) {
	my %possible_words;

	# Challenge only wants words greater
	# than 5 so just keep those
	for $filename.IO.lines -> $line {
		%possible_words{$line.lc} = 1
			if ($line.chars >= 5);
	}

	return %possible_words
}
