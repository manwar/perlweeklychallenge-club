#!perl 
use strict;
my @file_list = @ARGV;
@file_list = 'sample.txt' unless @file_list;
my %letter_freq;

for my $IN_FILE (@file_list) {
	open (my $INH, '<', $IN_FILE); #Force mode to reduce ARGV mischief
	while (my $line = <$INH> ) {
		my @line_letters = split ('', lc($line));
		$letter_freq{$_}++ foreach @line_letters;
	}
}

my @used = sort keys %letter_freq;
for my $a_letter (@used) {
	next unless $a_letter ge 'a' and $a_letter le 'z';
	print "$a_letter: ".$letter_freq{$a_letter}."\n";
}
