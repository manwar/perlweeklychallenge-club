#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

sub create_watched_value {
    my $value = shift;
    my @past_values;
    my $assign = sub {
        my $new_val = shift;
        push @past_values, $value;
        $value = $new_val;
    };
    my $get_past_values = sub {
        return "@past_values";
    };
    my $get_current_value = sub {
        return $value;
    };
    return $assign, $get_past_values, $get_current_value;
}

my ($assign, $get_past, $get_current) = create_watched_value 10;
say "Current: ", $get_current->();
$assign->(15);
say "Current: ", $get_current->();
$assign->(20);
say "Current: ", $get_current->();
$assign->(5);
say "Current: ", $get_current->();
say "Past: ", $get_past->();
