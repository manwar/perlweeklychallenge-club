#!/usr/bin/perl

# Peter Campbell Smith - 2022-04-25
# PWC 162 task 2

use v5.28;
use strict;
use warnings;
use utf8;

my ($c, $j, $key, $letter, $matrix, $r, %used, @key, @letters, @plain,
	$plain, $fixed, $prev, %locate, $encrypted, $decrypted);

# Implement encryption and decryption using the Wheatstone-Playfair cipher.

# data
$key[0]   = 'playfair example';
$plain[0] = 'hide the gold in the tree stump';

$key[1]   = 'Perl and Raku';
$plain[1] = 'The Weekly Challenge';

$key[2]   = 'the quick brown fox jumps over the lazy dog';
$plain[2] = q[The curfew tolls the knell of parting day, the lowing herd winds slowly o'er the lea];

# loop over key/plaintext pairs
for ($j = 0; $key[$j]; $j ++) {
	
	# create matrix
	say qq[\nPlaintext: $plain[$j]\nKey: $key[$j]];
	$key = lc($key[$j]);
	$key =~ s|[^a-z]||g;
	@letters = split(//, $key);
	
	# put the unique letters of the key into successive cells of the matrix
	($r, $c) = (0, 0);
	%used = ();
	for $letter (@letters) {
		$letter = 'i' if $letter eq 'j';
		next if $used{$letter};   # seen this letter already
		$used{$letter} = 1;
		$$matrix[$r][$c] = $letter;
		$locate{$letter} = [$r, $c];   # row and column containing $letter
		$c ++;
		if ($c == 5) {  # reached the end of a row
			$c = 0;
			$r ++;
		}
	}
	
	# now add the rest of the alphabet
	for $letter ('a' .. 'z') {
		$letter = 'i' if $letter eq 'j';
		next if $used{$letter};
		$used{$letter} = 1;
		$$matrix[$r][$c] = $letter;
		$locate{$letter} = [$r, $c];
		$c ++;
		if ($c == 5) {
			$c = 0;
			$r ++;
		}
	}
	
	# show matrix
	say qq[Matrix:];
	for $r (0..4) {
		for $c (0..4) {
			print $$matrix[$r][$c] . ' ';
		}
		say '';
	}
	
	# encrypt the plaintext
	$plain = lc($plain[$j]);
	$plain =~ s|[^a-z]||g;

	# insert 'x' to split paired letters
	$fixed = $prev = '';
	while ($plain =~ m|(.)|g) {
		$fixed .= 'x' if ($1 eq $prev and length($fixed) % 2 == 1);
		$fixed .= $1;
		$prev = $1;
	}
	
	# suffix 'x' if text has odd length
	$fixed .= 'x' if (length($fixed) % 2 == 1);
	
	# encrypt text 2 letters at a time
	$encrypted = '';
	while ($fixed =~ m|(.)(.)|g) {
		$encrypted .= playfair(1, $1, $2);
	}
	say qq[Encrypted: $encrypted];
	
	# and decrypt it
	$decrypted = '';
	while ($encrypted =~ m|(.)(.)|g) {
		$decrypted .= playfair(0, $1, $2);
	}
	say qq[Decrypted: $decrypted];	
}

sub playfair {   # (encrypt, letter1, letter2)
	
	my ($encrypt, $g1, $g2) = @_;
	my ($g1_row, $g1_col, $g2_row, $g2_col);
	
	# get the row and column coordinates of each letter
	($g1_row, $g1_col) = @{$locate{$g1}};
	($g2_row, $g2_col) = @{$locate{$g2}};
	
	# the letter pair defines a rectangle - swap their columns
	if ($g1_row != $g2_row && $g1_col != $g2_col) {
		return $$matrix[$g1_row][$g2_col] . $$matrix[$g2_row][$g1_col];
		
	# pair in same column - shift down to encrypt, up to decrypt
	} elsif ($g1_col == $g2_col) {
		if ($encrypt) {
			return $$matrix[($g1_row + 1) % 5][$g1_col] . $$matrix[($g2_row + 1) % 5][$g2_col];
		} else { # decrypt
			return $$matrix[($g1_row + 4) % 5][$g1_col] . $$matrix[($g2_row + 4) % 5][$g2_col];
		}
		
	# pair in same row - shift right to encrypt, left to decrypt
	} elsif ($g1_row == $g2_row) {
		if ($encrypt) {
			return $$matrix[$g1_row][($g1_col + 1) % 5] . $$matrix[$g2_row][($g2_col + 1) % 5];
		} else { # decrypt
			return $$matrix[$g1_row,][($g1_col + 4) % 5] . $$matrix[$g2_row][($g2_col + 4) % 5];
		}
	}
}
