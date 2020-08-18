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

sub new
{
    my $class = shift;
    my $class = ref($class) || $class;
    my $self = {
        _name1 = $_[0],
    };
    bless $self, $class;
    return $self;
}

sub majorityElement
{
    my (@arr) = @_;
    my $result = -1;

    return $result;
}

1;
