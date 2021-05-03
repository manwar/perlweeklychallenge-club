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

#
# To check for valid phone numbers, we will do the following:
#    - Remove all whitespace
#    - Replace a leading '+' by '00'
#    - Replace a leading '(NN)' by '0000'
#
# The number is valid, if and only if we are left with exactly 14 digits.
#

while (<>) {
    print if s{\s+}           {}gr     # Remove white space
          =~ s{^\+}           {00}r    # Replace leading + with 00
          =~ s{^\([0-9]{2}\)} {0000}r  # Replace leading (NN) with 0000
          =~  /^[0-9]{14}$/            # Check if 14 digits are left
}


__END__
