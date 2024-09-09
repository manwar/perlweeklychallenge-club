#!/usr/bin/perl
use v5.38;

# This script solves the problem "No Connection" in the PWC #285.
# The input is a list of connections, each line containing two points
# separated by a space. The output is a list of endpoints that are not
# connected to any other point.

my @connections;
while (<>) {
    chomp;
    last if !length;
    my ($a, $b) = split ' ';
    die "Invalid input: $_" unless length $a && length $b;
    push @connections, [ $a, $b ];
}

my %is_startpoint = map { $_->[0] => 1 } @connections;
my %is_unconnected_endpoint = map { $_->[1] => 1 }
    grep { !exists $is_startpoint{$_->[1]} } @connections;
say $_ for sort keys %is_unconnected_endpoint;

__END__
