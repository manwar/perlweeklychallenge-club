#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 11102.pl
#
#        USAGE: ./11102.pl WORDFILE [ INENC [ OUTENC ] ]
#
#  DESCRIPTION: Output the longest English alpha-sorted words
#
#      OPTIONS: Dictionary defaults to /usr/share/dict/words if WORDFILE
#               is not supplied.
#               Input encoding defaults to us-ascii if unspecified
#               Output encoding defaults to input encoding if unspecified
# REQUIREMENTS: Perl 5.16 for 'fc'
#        NOTES: WORDFILE must have one word only per line.
#         BUGS: The supplied words are only assumed to be English words: GIGO.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 04/05/21
#===============================================================================

use strict;
use warnings;
use feature 'fc';
use feature 'say';

my $dict    = shift // '/usr/share/dict/words';
my $enc_in  = shift // 'us-ascii';
my $enc_out = shift // $enc_in;
my $length  = 0;
my @longest;

open my $wordsfh, "<:encoding($enc_in)", $dict or
	die "Dictionary $dict not accessible: $!";

# $length and $wlen include the EoL char(s). We only use these vars for
# comparison, so this is fine and more efficient.
while (my $word = <$wordsfh>) {
	my $wlen = length $word;
	next if $length > $wlen;
	chomp $word;
	next unless is_sorted ($word);
	if ($length < $wlen) {
		$length = $wlen;
		@longest = ($word);
	} else {
		push @longest, $word;
	}
}

binmode STDOUT, ":encoding($enc_out)";
say join "\n", @longest;

sub is_sorted {
	my @chars = split //, fc shift;
	for my $i (0 .. $#chars - 1) {
		return if 1 == ($chars[$i] cmp $chars[$i + 1]);
	}
	return 1;
}
