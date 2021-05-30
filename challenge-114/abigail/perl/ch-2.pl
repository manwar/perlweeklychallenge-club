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
# Run as: perl ch-2.pl < input-file
#

#
# For a description of the algorithm, see
# https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-114-2.html
#

say oct sprintf ("0b0%b" => $_) =~ s {01(1*)(0*)$} {10$2$1}r while <>;

__END__
