#!/usr/bin/perl

use v5.16;
use utf8;
use charnames qw(:full :short);
use Unicode::Normalize;
use Digest;
use Test2::V0;

#use constant DIGEST => 'SHA-384';
use constant DIGEST => 'SHA-1';

# The task appears to be very easy, especially because the specification
# comes along with a detailed description of an optimal implementation.
# This invites to go the extra mile.
# 
# - A unique "isomorphic canonicalization" is created.  By taking a
#   message digest of this canonicalization, isomorphic strings can be
#   identified by identical digests.
#
# - Extended grapheme clusters (see
#   https://www.unicode.org/reports/tr29/#Grapheme_Cluster_Boundaries)
#   are used to identify single "characters".  By normalization (using
#   canonical decomposition) different representations of the same
#   symbol are transformed into identical grapheme clusters.  See the
#   last test case for an example.
sub uni_iso_digest {
	# Normalize input (Normalization Form D - canonical decomposition)
	local $_ = NFD shift;

	my $digest = Digest->new(DIGEST);
	my $n = 0;
	my %chars;
	my @canon;

	# Assign an ascending number to every new character appearing in the
	# string and append the current number's bits to the message.
	# Use \X to grab for a grapheme cluster.
	while (s/(\X)//) {
		$chars{$1} = $n++ unless exists $chars{$1};
		$digest->add_bits(pack('L', $chars{$1}), 32);
		push @canon, $chars{$1};
	}

	# Return the canonicalization and the message digest in list
	# context.  Returns solely the digest in scalar context.
	(\@canon, $digest->hexdigest);
}

is uni_iso_digest('abc'), uni_iso_digest('xyz'), 'Example 1';
is uni_iso_digest('abb'), uni_iso_digest('xyy'), 'Example 2';
isnt uni_iso_digest('sum'), uni_iso_digest('add'), 'Example 3';

is uni_iso_digest('αββγ'), uni_iso_digest(9001), 'multi-byte vs. numeric';

# Nine code points form four separate characters with two
# different characters having two differing representations.
my $str = 
	"\N{LATIN CAPITAL LETTER A WITH DIAERESIS}" .

	"\N{LATIN CAPITAL LETTER A}" .
	"\N{COMBINING DIAERESIS}" . 

	"\N{LATIN CAPITAL LETTER A}" .
	"\N{COMBINING DIAERESIS}" . 
	"\N{COMBINING LONG STROKE OVERLAY}" .

	"\N{LATIN CAPITAL LETTER A}" .
	"\N{COMBINING LONG STROKE OVERLAY}" .
	"\N{COMBINING DIAERESIS}";

is uni_iso_digest($str), uni_iso_digest('xxyy'),
	'Take normalized grapheme clusters as the individual characters';

# Retrieve the canonicalization only:
my ($canon) = uni_iso_digest($str);
say "canonical: (@$canon)";

done_testing;
