#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 12401.pl
#
#        USAGE: ./12401.pl  
#
#  DESCRIPTION: Output a big female symbol
#
# REQUIREMENTS: Text::Banner
#         BUGS: Not the most circular of circles
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 03/08/21
#===============================================================================

use strict;
use warnings;
use Text::Banner;

my $size = 4;
my $shift = $size - 2;
my $banner = Text::Banner->new;
$banner->fill ('#');
$banner->size ($size);

$banner->set ('o');
my $out = $banner->get;
$out =~ s/^\s{$shift}//mg;

$banner->set ('+');
$out .= $banner->get;
$out =~ s/\n\s*\n/\n/g;

print $out;

