#!/usr/bin/perl

# Challenge 027
#
# Task #2
# Write a script that allows you to capture/display historical data. It could
# be an object or a scalar. For example
#
# my $x = 10; $x = 20; $x -= 5;
#
# After the above operations, it should list $x historical value in order.

use Modern::Perl;

{
    package LoggingScalar;
    sub TIESCALAR {
        my($class, $value) = @_;
        return bless [$value], $class;
    }
    sub FETCH {
        my($self) = @_;
        return $self->[-1];
    }
    sub STORE {
        my($self, $value) = @_;
        push @$self, $value;
    }
    sub show_hist {
        my($self) = @_;
        say join(" ", @$self);
    }
}

tie my $x, 'LoggingScalar', 10;
$x = 20;
$x -= 5;
tied($x)->show_hist();
