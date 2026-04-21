#!/usr/bin/perl
use strict;
use warnings;

sub good_strings {
    my ($words_ref, $source) = @_;

    # validation
    die "words must be an array reference"
        unless ref($words_ref) eq 'ARRAY';

    die "source must be a lowercase string (a-z only)"
        unless defined $source && $source =~ /^[a-z]+$/;

    for my $word (@$words_ref) {
        die "each word must be lowercase (a-z only)"
            unless defined $word && $word =~ /^[a-z]+$/;
    }

    my $sum = 0;

    my %source_count;
    $source_count{$_}++ for split //, $source;

    for my $word (@$words_ref) {

        next if length($word) > length($source);

        my %count = %source_count;

        my $can_build = 1;

        for my $char (split //, $word) {
            if (!$count{$char}) {
                $can_build = 0;
                last;
            }
            $count{$char}--;
        }

        $sum += length($word) if $can_build;
    }

    return $sum;
}

# Tests

my @words;
my $chars;

# Example 1
@words = ("cat", "bt", "hat", "tree");
$chars = "atach";
print good_strings(\@words, $chars), "\n"; # Output: 6

# Example 2
@words = ("hello", "world", "challenge");
$chars = "welldonehopper";
print good_strings(\@words, $chars), "\n"; # Output: 10
