#!perl

use strict;
use warnings FATAL => qw(all);

=prompt

Write a script that dumps its own source code. For example, say, the script name is ch-2.pl then the following command should returns nothing. perl ch-2.pl | diff - ch-2.pl

=cut

open my $in, "<", $0 or die "$!";
for ( <$in> ) {print $_;}
