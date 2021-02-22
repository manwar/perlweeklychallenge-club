#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 9701.pl
#
#        USAGE: ./9701.pl STRING N 
#
#  DESCRIPTION: Caesar cipher - rotate STRING by N steps left
#
#         BUGS: Well, it does have string eval, so ...
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 25/01/21
#===============================================================================

use strict;
use warnings;

my ($text, $key) = @ARGV;

my $src  = join '', 'A' .. 'Z';
my $dest = join '', map { chr ($_ % 26 + 65) } -$key .. (25 - $key);

eval "\$text =~ tr/$src/$dest/;";

print $text . "\n";
