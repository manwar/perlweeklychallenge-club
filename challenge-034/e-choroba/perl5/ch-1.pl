#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

my @keys = qw( not_this_one
               this_one
               this_one_too
               it_was_enough );

my %hash = (not_this_one  => 'not selected',
            this_one      => 'selected first',
            this_one_too  => 'selected second',
            it_was_enough => 'not selected either');

my %dispatch = (show_array_slice       => \&show_array_slice,
                show_hash_slice        => \&show_hash_slice,
                show_index_value_slice => \&show_index_value_slice);

my $what_to_show = shift;
my $action = $dispatch{$what_to_show}
           || sub { die "Unknown action $what_to_show!\n" };
$action->();

sub show_array_slice {
    say for @keys[1, 2];
}

sub show_hash_slice {
    say for @hash{ @keys[1, 2] };
}

sub show_index_value_slice {
    my %selected = %hash{ @keys[1, 2] };
    say for values %selected;
}
