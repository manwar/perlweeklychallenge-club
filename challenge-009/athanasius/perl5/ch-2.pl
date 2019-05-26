#!/usr/bin/perl

use strict;
use warnings;
use Const::Fast;

const my @RANKINGS => qw( Standard Modified Dense Ordinal Fractional );
const my %RANKINGS => (
                          Standard   => \&rank_data_standard,
                          Modified   => \&rank_data_modified,
                          Dense      => \&rank_data_dense,
                          Ordinal    => \&rank_data_ordinal,
                          Fractional => \&rank_data_fractional,
                      );

$| = 1;

MAIN:
{
    my $data    = read_data();
    my $ordered = order_data($data);

    for my $ranking (@RANKINGS)
    {
        my $ranked = $RANKINGS{$ranking}->($ordered);
        print "\n$ranking Ranking:\n";
        print($_->[0], "\t", $_->[1], "\n") for @$ranked;
    }
}

sub read_data
{
    my %scores;

    while (<DATA>)
    {
        my  ($name,  $score) = split;
        push $scores{$score}->@*, $name;
    }

    return \%scores;
}

sub order_data
{
    my ($data) = @_;
    my  @ordered;

    for my $score (sort { $b <=> $a } keys %$data)  # Descending
    {
        push @ordered, [ sort $data->{$score}->@* ];
    }

    return \@ordered;
}

sub rank_data_standard
{
    my ($ordered) = @_;
    my  $rank     = 1;
    my  @ranked;

    for my $equals (@$ordered)
    {
        push @ranked, [ $rank, $_ ] for @$equals;
        $rank += scalar @$equals;
    }

    return \@ranked;
}

sub rank_data_modified
{
    my ($ordered) = @_;
    my  $rank     = 0;
    my  @ranked;

    for my $equals (@$ordered)
    {
        $rank += scalar @$equals;
        push @ranked, [ $rank, $_ ] for @$equals;
    }

    return \@ranked;
}

sub rank_data_dense
{
    my ($ordered) = @_;
    my  $rank     = 1;
    my  @ranked;

    for my $equals (@$ordered)
    {
        push @ranked, [ $rank, $_ ] for @$equals;
        ++$rank;
    }

    return \@ranked;
}

sub rank_data_ordinal
{
    my ($ordered) = @_;
    my  $rank     = 1;
    my  @ranked;

    for my $equals (@$ordered)
    {
        push @ranked, [ $rank++, $_ ] for @$equals;
    }

    return \@ranked;
}

sub rank_data_fractional
{
    my ($ordered) = @_;
    my  $rank     = 1;
    my  @ranked;

    for my $equals (@$ordered)
    {
        my $count = scalar @$equals;
        my $sum   = 0;
           $sum  += $rank++ for 1 .. $count;
        my $fract = $sum / $count;
        push @ranked, [ $fract, $_ ] for @$equals;
    }

    return \@ranked;
}

__DATA__
Fred 2.5
Wilma 7.2
Pebbles 7.2
Barney 0.1
Betty 0.9
Bamm-Bamm 0.9
