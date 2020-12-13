#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# y/// does the required replacements, and returns the number
# of characters replaced -- which turns out to be the length
# of the sequence. So, we first print the length of the sequence,
# followed by the modified sequence.
#
print y/TAGC/ATCG/, "\n", $_ while <>;

__END__
