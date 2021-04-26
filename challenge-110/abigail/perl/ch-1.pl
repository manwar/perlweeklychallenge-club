#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#
#
# The examples show we should not take the specification as a specification;
# just a rough guideline. According to the specification, 
# " +44 1148820341" fails the criteria not once, but twice: it contains
# a leading space (not allowed in the specification), and it has only a
# single space between the '+44' part and the rest, where the specification
# requires two.
# 
# We therefore conclude the examples just contain random spaces, and we
# can completly ignore any white space in the input.
# 

while (<>) {
    print if s/\s+//gr =~ /^ (?: \+\d{12} | \(\d{2}\)\d{10} | \d{14} )$/ax
}


__END__
