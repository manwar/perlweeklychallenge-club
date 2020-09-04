#!/usr/bin/perl
# Test: ./ch-2.pl
use Modern::Perl;
use Data::Dumper;

my $matrix = letters_to_matrix(shift);
my $words  = dictionary_to_hash(shift);

my $max_height = scalar @$matrix;
my $max_width  = scalar @{$matrix->[0]};
my @answers;

# Loop through each letter
# from left to right
for my $i (0 .. $max_height - 1) {
	for my $j (0 .. $max_width - 1) {
		push @answers,
		     find_words($matrix, $words, $i,
		                $j, $max_height, $max_width);
	}
}

say "Found " . scalar(@answers) . " words:";
say join ', ', sort @answers;

sub find_words {
	my ($matrix, $words, $row, $col, $h, $w) = @_;
	my @found;

	# Orthogonal directions with 1 on top
	# 1t 2tr 3r 4br 5b 6bl 7l 8tl
	for my $x (1 .. 8) {
		my $i = $row;
		my $j = $col;
		my $possible_word = '';

		while ($i >= 0 && $j >=0 && $i < $h && $j < $w) {
			$possible_word .= lc($matrix->[$i][$j]);

			push @found, $possible_word
				if ($words->{$possible_word});

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
sub letters_to_matrix {
	my $filename = shift || 'challenge.txt';
	my @letter_matrix;

	open(my $fh, '<:encoding(UTF-8)', $filename) || die "$@";
	while (my $row = <$fh>) {
		chomp $row;
		my @letters = split (' ', $row);
		push @letter_matrix, \@letters;
	}

	return \@letter_matrix
}

# Load the dictionary into memory
sub dictionary_to_hash {
	my $filename = shift || 'words.txt';
	my %possible_words;

	# Challenge only wants words greater
	# than 5 so just keep those
	open(my $fh, '<:encoding(UTF-8)', $filename) || die "$@";
	while (my $row = <$fh>) {
		chomp $row;
		$possible_words{lc($row)} = 1
			if (length($row) >= 5);
	}
	return \%possible_words;
}
