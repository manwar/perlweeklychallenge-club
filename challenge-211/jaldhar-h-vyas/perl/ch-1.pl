#!/usr/bin/perl
use 5.030;
use warnings;

sub batch {
    my @range = @{$_[0]};
    my $quantity = $_[1];

    if ($quantity < 1 || $quantity > scalar @range) {
        die "out of range\n";
    }

    my $length = scalar @range;
    my $i = 0;
    while ($i < $length) {
        my @row;
        for (1 .. $quantity) {
            push @row, shift @range;
            $i++;
            if ($i == $length) {
                last;
            }
        }
        push @range, [@row];
    }

    return wantarray ? @range : $range[0];
}

sub diagonal {
    my ($matrix, $r, $c, $row, $col) = @_;
    my $i = $row;
    my $j = $col;
    my $same = $matrix->[$i]->[$j];

    while ($i < $r && $j < $c) {
        if ($matrix->[$i]->[$j] != $same) {
            return undef;
        }
        $i++;
        $j++;
    }
    return 1;
}

my $r = shift;
my $c = shift;
my @matrix = batch(\@ARGV, $c);

for my $col (0 .. $c - 1) {
    unless (diagonal(\@matrix, $r, $c, 0, $col)) {
        say 'false';
        exit;
    }
}

for my $row (1 .. $r - 1) {
    unless (diagonal(\@matrix, $r, $c, $row, 0)) {
        say 'false';
        exit;
    }
}

say "true";