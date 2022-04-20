#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Compare;
use List::Util qw{ uniq };

my @dict = get_dict();

# maybe flag to enable this filter?
@dict = grep { is_abecedarian($_) } @dict;

sub is_abecedarian ( $word ) {
    my $dorw = join '', sort { lc $a cmp lc $b } split //, $word;
    return $dorw eq $word ? 1 : 0;
}

my $pangram = get_pangram( \@dict );
say $pangram;

sub get_pangram ( $wordlist, $gram = '' ) {
    $gram =~ s/^\s//mix;
    my $test = join '', ' ', 'a' .. 'z';
    my %letters;
    for my $l ( split //, lc $gram ) { $letters{$l} = 1; }
    my $sheet = join '', sort keys %letters;
    return $gram if $test eq join '', sort keys %letters;

    my @gram = split //, $gram;

    ## wrecker yard of abandoned sorts
    # for my $next ( sort { rand 1 <=> rand 1 } $wordlist->@* ) {
    # for my $next ( sort { length $a <=> length $b } $wordlist->@* ) {
    # sort { ronly_size( $gram, $a ) <=> ronly_size( $gram, $b ) }
    # sort { lonly_size( $gram, $b ) <=> lonly_size( $gram, $a ) }
    # sort { length $a <=> length $b }
    # sort {
    #     ronly_minus_lonly( $gram, $a ) <=> ronly_minus_lonly( $gram, $b )
    # }
    # sort { rand 1 <=> rand 1 }

    # prefering short words to long
    for my $next ( sort { length $a <=> length $b } $wordlist->@* ) {

    # for my $next (
    #     sort {
    #         ronly_minus_lonly( $gram, $a ) <=> ronly_minus_lonly( $gram, $b )
    #     } $wordlist->@*
    #     )
    # {
        my @next = split //, $next;
        my $lc   = List::Compare->new( \@gram, \@next );
        my @comp = $lc->get_Ronly; 
        if ( scalar @comp ) {
            return get_pangram( $wordlist, join ' ', $gram, $next );
        }
    }

    # Sir, the impossible scenario we never planned for?
    # Well, we better come up with a plan.
    return 'SHOULD NEVER RETURN';
}

# functions for size of left_only, size of right_only, and a 
# difference that should prioritize new words

sub ronly_minus_lonly ( $w1, $w2 ) {
    my $lonly = lonly_size( $w1, $w2 );
    my $ronly = ronly_size( $w1, $w2 );
    return $ronly - $lonly;
}

sub lonly_size ( $w1, $w2 ) {
    my @w1 = uniq sort split //, lc $w1;
    my @w2 = uniq sort split //, lc $w2;
    my $lc = List::Compare->new( \@w1, \@w2 );
    return scalar $lc->get_Lonly;
}

# in usage, w1 is the attempted pangram and w2 is the word
# being considered. List::Compare takes two lists (duh)
# and gives many tools to compare them. Ronly is right-only,
# so, given arrays of letters, this returns the count of letters
# that only exist in the right one, so we would prefer to add 
# words with a high Ronly count.
sub ronly_size ( $w1, $w2 ) {
    my @w1 = uniq sort split //, lc $w1;
    my @w2 = uniq sort split //, lc $w2;
    my $lc = List::Compare->new( \@w1, \@w2 );
    return scalar $lc->get_Ronly;
}

sub get_dict() {
    if ( open my $fh, '<', 'dictionary.txt' ) {
        my @output;
        while ( my $word = <$fh> ) {
            chomp $word;
            push @output, $word;
        }
        return @output;
    }
    exit;
}

