#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use Getopt::Long;

my $word_grid  = 'word_grid.txt';
my $dictionary = '/usr/share/dict/words';
my $output     = {};

GetOptions(
    'dictionary=s' => \$dictionary,
    'wordsearch=s' => \$word_grid,
);

my $words       = get_words($dictionary);
my $word_search = get_word_search($word_grid);

do_word_search( $word_search, $words );

my $wc = scalar keys $output->%*;
say join "\n\t", "There were $wc unique words in this word search",
    sort keys $output->%*;

sub do_word_search ( $graph, $dictionary ) {
    my $xp = scalar $graph->@* - 1;
    my $yp = scalar $graph->[0]->@* - 1;

    for my $x ( 0 .. $xp ) {
        for my $y ( 0 .. $yp ) {
            my $l = $graph->[$x][$y];
            find_word_vertical( $x + 1, $y, [$l], $graph, $dictionary );
            find_word_horizontal( $x, $y + 1, [$l], $graph, $dictionary );
            find_word_diagonal( $x + 1, $y + 1, [$l], $graph, $dictionary );
            find_word_diagonal2( $x + 1, $y - 1, [$l], $graph, $dictionary );
        }
    }
}

sub find_word_vertical ( $x, $y, $strp, $graph, $dictionary ) {
    my $l = $graph->[$x][$y];
    return unless defined $l;
    push $strp->@*, $l;
    my $w1 = join '', $strp->@*;
    my $w2 = join '', reverse $strp->@*;
    $output->{$w1}++ if $dictionary->{$w1};
    $output->{$w2}++ if $dictionary->{$w2};
    find_word_vertical( $x + 1, $y, $strp, $graph, $dictionary );
}

sub find_word_horizontal ( $x, $y, $strp, $graph, $dictionary ) {
    my $l = $graph->[$x][$y];
    return unless defined $l;
    push $strp->@*, $l;
    my $w1 = join '', $strp->@*;
    my $w2 = join '', reverse $strp->@*;
    $output->{$w1}++ if $dictionary->{$w1};
    $output->{$w2}++ if $dictionary->{$w2};
    find_word_horizontal( $x, $y + 1, $strp, $graph, $dictionary );
}

sub find_word_diagonal ( $x, $y, $strp, $graph, $dictionary ) {
    my $l = $graph->[$x][$y];
    return unless defined $l;
    push $strp->@*, $l;
    my $w1 = join '', $strp->@*;
    my $w2 = join '', reverse $strp->@*;
    $output->{$w1}++ if $dictionary->{$w1};
    $output->{$w2}++ if $dictionary->{$w2};
    find_word_diagonal( $x + 1, $y + 1, $strp, $graph, $dictionary );
}

sub find_word_diagonal2 ( $x, $y, $strp, $graph, $dictionary ) {
    my $l = $graph->[$x][$y];
    return unless defined $l;
    push $strp->@*, $l;
    my $w1 = join '', $strp->@*;
    my $w2 = join '', reverse $strp->@*;
    $output->{$w1}++ if $dictionary->{$w1};
    $output->{$w2}++ if $dictionary->{$w2};
    find_word_diagonal( $x + 1, $y - 1, $strp, $graph, $dictionary );
}

sub get_word_search( $file ) {
    my $ws = [];
    if ( -f $file && open my $fh, '<', $file ) {
        while ( my $line = <$fh> ) {
            my @line = map { uc $_ } split /\W/, $line;
            push $ws->@*, [@line];
        }
    }
    return wantarray ? $ws->@* : $ws;
}

sub get_words ($file) {
    my %words;
    if ( -f $file && open my $fh, '<', $file ) {
        while ( my $word = <$fh> ) {
            chomp $word;
            $word = uc $word;
            next if $word =~ /\W/;
            $words{$word} = 1;
        }
    }
    return wantarray ? %words : \%words;
}
