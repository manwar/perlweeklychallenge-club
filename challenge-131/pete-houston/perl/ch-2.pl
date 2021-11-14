#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 13102.pl
#
#        USAGE: ./13102.pl PAIRS STRING 
#
#  DESCRIPTION: Print the opening pairs and closing pairs from the
#               string separately.
#
# REQUIREMENTS: Perl 5.10 or newer
#         BUGS: If you think any string eval is a bug ...
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 20/09/21
#===============================================================================

use strict;
use warnings;
use feature 'say';

my ($open, $close);
my $pairs = shift;
for my $i (0 .. length ($pairs) - 1) {
	my $c = substr ($pairs, $i, 1);
	if ($i % 2) {
		$close .= $c;
	} else {
		$open .= $c;
	}
}

my $input = shift;
for my $cleaner (map quotemeta, $open, $close) {
	eval "say \$input =~ tr/$cleaner//cdr;";
}
