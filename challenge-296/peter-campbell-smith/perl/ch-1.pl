#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-11-18
use utf8;     # Week 296 - task 1 - String compression
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

string_compression('aaaaabbcdeffffghiiikklmnopp');
string_compression('a committee of bookkeepers');
string_compression('abbbbbbbbbbbbbbbbbbbbc');

# try a longer string of random a and b
my $chars;
$chars .= chr(int(rand(2) + ord('a'))) for 0 .. 199;
string_compression($chars);

sub string_compression {
	
	my ($chars, $chars2, $char, $count, $c, $de);
	
	# initialise
	$chars = shift;
	say qq[\nInput:        \$chars = '$chars'];
	$chars .= chr(0);
	$chars2 = '';	
	$char = '';
	$count = 0;
	
	# loop over characters in $chars
	for $c (split('', $chars)) {
		
		# same as previous
		if ($c eq $char) {
			$count ++;
			
		# different from previous	
		} else {
			$chars2 .= ($count > 0 ? $count + 1 : '') . $char;
			$count = 0;
			$char = $c;
		}
	}
	$chars = substr($chars, 0, -1);
	
	# report
	$de = string_decompression($chars2);
	say qq[Compressed:   \$chars = '$chars2'];
	say qq[Decompressed: \$chars = '$de'];
	say qq[Result:       ] . ($de eq $chars ? 'good - ' : 'bad - ') . 'compressed to ' .
		(int(length($chars2) / length($chars) * 100)) . '%';
}

sub string_decompression {
	
	my ($chars, $chars2, $count, $c);
	
	# initialise
	$chars = shift;
	$chars2 = '';
	$count = 0;	
	$chars .= chr(0);
	
	# loop over chars in $chars
	for $c (split('', $chars)) {
		
		# a number (might be > 9)
		if ($c =~ m|\d|) {
			$count = $count * 10 + $c;
			
		# a letter
		} else {
			$count = 1 unless $count;
			$chars2 .= $c for 1 .. $count;
			$count = 0;
		}
	}
	return substr($chars2, 0, -1);
}
