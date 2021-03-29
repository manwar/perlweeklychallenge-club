#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 10502.pl
#
#        USAGE: ./10502.pl NAME
#
#  DESCRIPTION: Output "The Name Game" lyrics based upon the given name.
#
# REQUIREMENTS: Text::Unidecode, Encode
#         BUGS: Assumes the encoding of NAME is utf-8
#               Relies on Text::Unidecode
#               Assumes a consonant is anything which is not a vowel
#        NOTES: Tested with Roman and Greek alphabets only. YMMV.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 22/03/21
#===============================================================================

use strict;
use warnings;
use Encode 'decode';
use Text::Unidecode;

binmode STDOUT, ':utf8';
my $n = decode ('UTF-8', shift);

# Prune the leading consonants, if any.
# Turn all vowels into ASCII equivalents for detection purposes
# Assume that anything which isn't a vowel is a consonant.
my ($consonants) = unidecode ($n) =~ /^([^aeiou]*)/i;
my $trail = lc $n;
my $s = substr ($trail, 0, length ($consonants), '');

my ($trimlead, $trimrest) = ('' ne $s) ? split //, lc ($s), 2 : ('', '');
$trimlead = unidecode ($trimlead);

# Closure to handle leading b, f, m special cases.
sub lead {
	my $l = shift;
	return ($trimlead eq $l ? $trimrest : $l) . $trail;
}

my %h;
$h{$_} = lead ($_) for qw/b f m/;

print <<EOT;
$n, $n, bo-$h{b}
Bonana-fanna fo-$h{f}
Fee fi mo-$h{m}
$n!

EOT
