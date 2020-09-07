# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Task1.pm
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Description:
#=============================================================================

package Task1;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw();
our @EXPORT_OK = qw();

sub new
{
    my $class = shift;
    $class = ref($class) || $class;
    my $self = {
        _name1 => $_[0],
    };
    bless $self, $class;
    return $self;
}

sub run
{
    my $self = shift;
    return undef;
}

1;

