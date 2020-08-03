#!/usr/bin/perl
# Test: ./ch-2.pl
use Modern::Perl;

my $A = shift // 10;
my $B = shift // 20;

die ("$B needs to be >= than $A")
	unless ($A > 1 && $B >= $A);

my $input_file = '/usr/share/dict/words';

open my $fh, '<', $input_file or die "$input_file: $!";
while( <$fh> ) {
	if( $. >= $A && $. <= $B ) {
		print $_;
	}
}

close $fh;
