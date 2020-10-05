#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use autodie;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(reduce);

run_challenge();

sub run_challenge() {
    my ($input_file) = @ARGV;
    my $frequencies_to_words =
      frequency_sort( words( sanitize_input( read_file($input_file) ) ) );
    print_word_frequencies($frequencies_to_words);
}

sub print_word_frequencies($frequencies) {
    say join( ' ', $_, @{ $frequencies->{$_} } )
      for sort { $a <=> $b } keys %{$frequencies};
}

sub frequency_sort(@words) {
    my %word_count;
    $word_count{$_}++ for @words;
    my %frequencies;
    push @{ $frequencies{ $word_count{$_} } }, $_ for sort keys %word_count;

    return \%frequencies;
}

# split the given string into words
sub words($str) {
    return split( /\s+/, $str );
}

# replace illegal chars with whitespace
sub sanitize_input($input) {
    return $input =~ s/[\."\(\),]|--|'s/ /rg;
}

# read the whole file
sub read_file($filename) {
    local $/ = undef;
    open( my $fh, '<', $filename );
    my $out = <$fh>;
    close($fh);
    return $out;
}

