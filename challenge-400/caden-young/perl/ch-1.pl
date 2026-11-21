#!/usr/bin/env perl
use v5.16;
use strict;
use warnings;

# Each consecutive group of the ordered search space is represented by its
# minimum, maximum and largest internal gap. Joining consecutive groups adds
# exactly one possible gap: the distance between their adjacent endpoints.
sub join_groups {
    my ($left, $right, $offset) = @_;
    return $left unless defined $right;
    my ($first, $last, $inside) = @$right;
    $first += $offset;
    $last  += $offset;
    return [$first, $last, $inside] unless defined $left;
    my $largest = $left->[2];
    $largest = $inside if $inside > $largest;
    my $between = $first - $left->[1];
    $largest = $between if $between > $largest;
    return [$left->[0], $last, $largest];
}

my %free_suffix;
sub suffix_group {
    my ($used, $places, $limit) = @_;
    return [0, 0, 0] if $places == 0;
    my $key = "$used/$places";
    return $free_suffix{$key} if !defined($limit) && exists $free_suffix{$key};
    my $ceiling = defined($limit) ? substr($limit, 0, 1) : 9;
    my $place_value = 10 ** ($places - 1);
    my $group;
    for my $digit (0 .. $ceiling) {
        my $bit = 1 << $digit;
        next if $used & $bit;
        my $rest = defined($limit) && $digit == $ceiling ?
substr($limit, 1) : undef;
        my $child = suffix_group($used | $bit, $places - 1, $rest);
        $group = join_groups($group, $child, $digit * $place_value);
    }
    $free_suffix{$key} = $group unless defined $limit;
    return $group;
}

sub largest_interval {
    my ($limit) = @_;
    die "Expected a positive integer\n" unless defined($limit) &&
$limit =~ /\A[0-9]+\z/;
    $limit =~ s/\A0+//;
    die "Expected a positive integer\n" if $limit eq '';
    # Once all ten digits have appeared, no further digit can be appended.
    $limit = '9876543210' if length($limit) > 10 || (length($limit) ==
10 && $limit gt '9876543210');
    my $all;
    for my $width (1 .. length($limit)) {
        my $bounded = $width == length($limit);
        my $first_max = $bounded ? substr($limit, 0, 1) : 9;
        for my $first (1 .. $first_max) {
            my $suffix_limit = $bounded && $first == $first_max ?
substr($limit, 1) : undef;
            my $child = suffix_group(1 << $first, $width - 1, $suffix_limit);
            $all = join_groups($all, $child, $first * 10 ** ($width - 1));
        }
    }
    return $all->[2];  # A singleton has no jump, so its largest gap is zero.
}

unless (caller) {
    die "Usage: perl ch-1.pl LIMIT\n" unless @ARGV == 1;
    say largest_interval($ARGV[0]);
}
1;
