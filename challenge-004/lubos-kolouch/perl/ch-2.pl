#!/usr/bin/env perl
use v5.36;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-2.pl - Perl Weekly Challenge 004 Task 2: Word Match

=head1 SYNOPSIS

  perl ch-2.pl abc words.txt
  cat words.txt | perl ch-2.pl abc
  perl ch-2.pl --test

=head1 DESCRIPTION

Given a list of letters and a list of words, prints each word that can be built
using only the given letters, case-insensitively, with each letter usable at
most once.

=cut

sub letter_counts ($text) {
    my %counts;
    for my $char ( split //, lc $text ) {
        next if $char !~ /[a-z]/;
        $counts{$char}++;
    }
    return \%counts;
}

sub can_build_word ( $word, $letters_count ) {
    my %need;
    for my $char ( split //, lc $word ) {
        return 0 if $char !~ /[a-z]/;
        $need{$char}++;
        return 0 if $need{$char} > ( $letters_count->{$char} // 0 );
    }
    return 1;
}

sub matching_words ( $letters, $words_ref ) {
    my $letters_count = letter_counts($letters);
    my @matches;

    for my $word (@$words_ref) {
        push @matches, $word if can_build_word( $word, $letters_count );
    }
    return \@matches;
}

sub run_tests {
    require Test::More;
    Test::More->import;

    is_deeply(
        matching_words( 'abc', [ 'cab', 'baa', 'Dad' ] ),
        ['cab'],
        'uses only available letters and counts'
    );

    is_deeply(
        matching_words( 'aAbB', [ 'ab', 'bA', 'aba', 'BBa' ] ),
        [ 'ab', 'bA', 'aba', 'BBa' ],
        'case-insensitive matching with duplicates'
    );

    done_testing();
}

if ( @ARGV && $ARGV[0] eq '--test' ) {
    run_tests();
    exit 0;
}

my $letters = shift @ARGV;
die "Usage: perl $0 <letters> [words-file]\n" if !defined $letters;

my @words;
if (@ARGV) {
    my $file = shift @ARGV;
    open my $fh, '<', $file or die "Cannot open '$file': $!\n";
    while ( my $line = <$fh> ) {
        chomp $line;
        next if $line eq '';
        push @words, $line;
    }
    close $fh;
}
else {
    while ( my $line = <> ) {
        chomp $line;
        next if $line eq '';
        push @words, $line;
    }
}

say for @{ matching_words( $letters, \@words ) };
