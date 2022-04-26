#!/usr/bin/env perl
#===============================================================================
#
#         FILE: 16101.pl
#
#        USAGE: ./16101.pl  
#
#  DESCRIPTION: Display the Abecedarian Words sorted by length,
#               descending. 
#
# REQUIREMENTS: perl 5.16.0 for 'fc'
#        NOTES: Words from /usr/share/dict/words - why not?
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 19/04/22
#===============================================================================

use strict;
use warnings;
use feature 'fc';

my @abc = get_abecedarians ();
@abc = sort { length ($b) <=> length ($a) || $a cmp $b } @abc;
print "$_\n" for @abc;

sub get_abecedarians {
	my $dict = '/usr/share/dict/words';
	open my $in, '<', $dict or die "Cannot open $dict for reading: $!";

	my @abc;
	while (my $str = <$in>) {
		chomp $str;
		push @abc, $str if is_abecedarian ($str);
	}
	close $in;
	return @abc;
}

sub is_abecedarian {
	my $word = shift;

	# Alpha-ordering should be case-insensitive
	$word = fc $word;
	my $lastchr = substr ($word, 0, 1);
	for my $pos (1 .. length $word) {
		my $chr = substr ($word, $pos, 1);
		next unless $chr =~ /[[:alpha:]]/; # Expensive, but finite set
		return 0 if 1 == ($lastchr cmp $chr);
		$lastchr = $chr;
	}
	return 1;
}
