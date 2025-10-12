#!/usr/bin/env perl

use v5.38;
use List::Util qw< mesh >;
no warnings 'uninitialized';

sub balanced {
    die "`$_[0]' must contain [a-z0-9]" if $_[0] !~ /^[a-z0-9]*$/;
    my ($one, $two) = ([], []);

    push @{ /\d/ ? $one : $two }, $_ for sort split '', $_[0];
    return "" if abs(@$one - @$two) > 1; # C'est impossible

    join '', mesh sort { @$b <=> @$a } $one, $two;
}
