# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# MajorityElement.pm
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Description:
#=============================================================================

package MajorityElement;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(majorityElement);
our @EXPORT_OK = qw();

sub majorityElement
{
    my (@arr) = @_;
    my $result = -1;
    my %presence;
    my $majorityThreshold = int(scalar(@arr)/2);

    # Count the repetitions.
    $presence{$_}++ foreach @arr;

    # Select the one that passes the threshold.  There can only be one or none.
    $result = (grep { $presence{$_} > $majorityThreshold } keys %presence)[0] // -1;

    return $result;
}

1;
