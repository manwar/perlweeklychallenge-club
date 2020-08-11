#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use constant SCALE => 4;

sub generate_bar_graph {
    my ($data, $bylabels) = @_;

    my @labels = sort { $data->{$b} <=> $data->{$a}} keys %{$data};
    my $smallest = $data->{$labels[$#labels]};

    if (defined $bylabels) {
        @labels = sort @labels;
    }

    my $width = length ((sort {length $b <=> length $a} @labels)[0]);
    my $bar_graph = q{};

    for my $label (@labels) {
        my $bar = ($data->{$label} / $smallest) * SCALE;
        if ($data->{$label} % $smallest) {
            $bar += SCALE / 2;
        }
        $bar_graph .= sprintf("% -*s | %s\n", $width, $label, '#' x $bar);
    }

    return $bar_graph;
}

my $data = { apple => 11, cherry => 5, banana => 2 };

print generate_bar_graph($data, 1);