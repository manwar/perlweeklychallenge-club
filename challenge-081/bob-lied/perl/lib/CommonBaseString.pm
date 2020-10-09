# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# CommonBaseString.pm
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Description:
#=============================================================================

package CommonBaseString;

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw();
our @EXPORT_OK = qw(commonPrefix);

sub new($class, $a, $b)
{
    $class = ref($class) || $class;
    my $self = {
        _a => $a,
        _b => $b,
    };
    bless $self, $class;
    return $self;
}

# 
sub commonPrefix($s, $t)
{
    my @s1 = split("", $s);
    my @s2 = split("", $t);
    my $prefix = "";
    my @possiblePrefixes = ();

    while ( @s1 && @s2 && ($s = shift @s1) eq ($t = shift @s2) )
    {
        $prefix .= $s;
        push @possiblePrefixes, $prefix;
    }
    return \@possiblePrefixes;
}

sub run($self)
{
    my ($A, $B) = @{$self}{qw(_a _b)};
    my ($lenA, $lenB) = ( length($A), length($B) );
    my @thisWorks = ();

    my $prefixes = commonPrefix($A, $B);

    for my $prefix ( @$prefixes )
    {
        my $lenP = length($prefix);
        # Only prefixes that can be repeated to the length of both strings
        # are candidates.
        next unless $lenA % $lenP == 0;
        next unless $lenB % $lenP == 0;

        # Number of repetitions required for each string.
        my $repA = $lenA / $lenP;
        my $repB = $lenB / $lenP;

        my $buildsA = ( ($prefix x $repA) eq $A );
        my $buildsB = ( ($prefix x $repB) eq $B );
        push @thisWorks, $prefix if ( $buildsA && $buildsB );
    }

    return \@thisWorks;
}

1;
