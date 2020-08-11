#!/usr/bin/perl
use warnings;
use strict;
use 5.020;

package Version;
use overload 'cmp' => 'compare';

sub new {
    my $class = shift;
    my %self;
    $self{version} = shift;
    return bless \%self, $class;
}

sub compare {
    my ($this, $that) = @_;
    $this->{version} =~ s/_(.+?)$//;
    my $underscore1 = $1 // 0;
    $that->{version} =~ s/_(.+?)$//;
    my $underscore2 = $1 // 0;

    my @ver1 = split /\./, $this->{version};
    my @ver2 = split /\./, $that->{version};
    my $l = scalar @ver1 < scalar @ver2 ? scalar @ver2 - 1 : scalar @ver1 - 1;

    for my $i (0 .. $l) {
        if (!defined $ver1[$i]) {
            return -1;
        }

        if (!defined $ver2[$i]) {
            return 1;
        }

        if ($ver1[$i] lt $ver2[$i]) {
            return -1;
        }

        if ($ver1[$i] gt $ver2[$i]) {
            return 1;
        }
    }

    if ($underscore1 < $underscore2) {
        return -1;
    }

    if ($underscore1 > $underscore2) {
        return 1;
    }

    return 0;
}

package main;
say Version->new($ARGV[0]) cmp Version->new($ARGV[1]);