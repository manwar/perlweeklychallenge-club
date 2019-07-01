#!/usr/bin/env perl

# http://neilb.org/2019/06/24/additional-challenge-14.html

use 5.026;
use strict;
use autodie;
use warnings;
use LWP::Simple;
use JSON;

my $usa_state_data_url = 'https://gist.githubusercontent.com/neilb/ee60cd179d5eb17d1cb616cdeeda760f/raw/3d31a508a5277ddb4df3a73fb14715102b452302/usa-state-data.json';

my $usa_state_data_json = get($usa_state_data_url)
    or die "Could not get $usa_state_data_url";

my $usa_state_data = decode_json($usa_state_data_json);

my @all_states = sort keys %$usa_state_data;

# Mark all states are non-visited yet.
$_->{visited} = 0 foreach values %$usa_state_data;

sub is_traversable_via {
    my ($word, $adjacents) = @_;

    foreach my $state (@{$usa_state_data}{@$adjacents}) {
        next if $state->{visited};
        my $initials = $state->{initials};
        next if $initials ne substr($word, 0, length($initials));
        return ($state) if length($initials) eq length($word);
        local $state->{visited} = 1;
        if (my @path = is_traversable_via(substr($word, length($initials)), $state->{adjacent})) {
            return ($state, @path);
        }
    }

    return;
}

my $largest_length_so_far = 0;
my @largest_words_so_far;

open my $dict, '<', '/usr/share/dict/words';
while (<$dict>) {
    chomp;
    my $word = $_;
    next unless length($word) >= $largest_length_so_far;
    if (my @path = is_traversable_via(lc $word, \@all_states)) {
        if (length($word) == $largest_length_so_far) {
            push @largest_words_so_far, [$word, \@path];
        } else {
            $largest_length_so_far = length($word);
            @largest_words_so_far = ([$word, \@path]);
        }
    }
}
close $dict;

foreach (@largest_words_so_far) {
    my ($word, $path) = @$_;
    say $word, ' (', join(' => ', map {$_->{name}} @$path), ')';
}
