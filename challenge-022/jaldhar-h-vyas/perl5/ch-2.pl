#!/usr/bin/perl
use warnings;
use strict;
use 5.018;
use English qw/ -no_match_vars /;

sub init_dict {
    my %dictionary = map { chr $_ => chr $_ } 0 .. 255;
    return \%dictionary;
}

sub uncompress {
    my ($data) = @_;
    my @output;
    my $dict = init_dict();
    my $i = scalar keys %{$dict};
    my $l = 0;
    my $p = $data->[$l];
    my $s = $dict->{$p};
    my $c = substr $s, 0, 1;

    push @output, $s;

    while ($l < scalar @{$data} - 1) {
        my $n = $data->[++$l];
        if (!exists $dict->{$n}) {
            $s = "$dict->{$p}$c";
        } else {
            $s = $dict->{$n};
        }
        push @output, $s;
        $c = substr $s, 0, 1;
        $dict->{++$i} = "$dict->{$p}$c";
        $p = $n;
    }

    return join q{}, @output;
}

sub compress {
    my ($data) = @_;
    my @output;
    my $dict = init_dict();
    my $i = scalar keys %{$dict};
    my $l = 0;
    my $p = substr $data, $l, 1;

    while ($l < length $data) {
        my $c = substr $data, ++$l, 1;
        if (exists $dict->{"$p$c"}) {
            $p = "$p$c";
        } else {
            push @output, $dict->{$p};
            $dict->{"$p$c"} = ++$i;
            $p = $c;
        }
    }

    push @output, $dict->{$p};

    return \@output;
}

my $phrase = 'TOBEORNOTTOBEORTOBEORNOT';
# There and back again...
say (($phrase eq uncompress(compress($phrase))) ? 'OK' : 'NOK');