#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

package Historical {
    use Tie::Scalar;
    use parent -norequire => 'Tie::StdScalar';

    our @history;

    sub TIESCALAR {
        my ($class, $value) = @_;
        push @history, "Storing <$value> (was [])";
        return bless \$value, $class;
    }

    sub STORE {
        my ($self, $value) = @_;
        push @history, "Storing <$value> (was [$$self])";
        $$self = $value;
    }
}

package main {

    tie my $x, 'Historical', 10;
    $x = 20;
    $x -= 5;

    say join "\n", @Historical::history;
}