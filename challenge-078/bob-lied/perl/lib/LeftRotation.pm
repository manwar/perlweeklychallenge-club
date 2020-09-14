# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# LeftRotation.pm
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Description:
#=============================================================================

package LeftRotation;

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw();
our @EXPORT_OK = qw();

sub new($class, $name1)
{
    $class = ref($class) || $class;
    my $self = {
        _name1 => $name1,
    };
    bless $self, $class;
    return $self;
}

sub run($self)
{
    return undef;
}

1;
