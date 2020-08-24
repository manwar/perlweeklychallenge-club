# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# FNR.pm
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Description: 
#=============================================================================

package FNR;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(firstNonRepeat);
our @EXPORT_OK = qw();

sub firstNonRepeat
{
    my ($s) = @_;
    my $result = "";
    my %charData;   # Save position and count of letters

    for my $i ( 0 .. length($s)-1 )
    {
        my $char = substr($s, $i, 1);
        $charData{$char}{cnt}++;
        $charData{$char}{pos} = $i unless exists $charData{$char}{pos};

        # Select non-repeating characters and sort by position
        my @nr = sort { $charData{$a}{pos} lt $charData{$b}{pos} }
                    grep { $charData{$_}{cnt} == 1 } keys %charData;

        $result .= $nr[0] // '#';
    }

    return $result;
}

1;
