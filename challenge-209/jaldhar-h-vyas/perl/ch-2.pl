#!/usr/bin/perl
use 5.030;
use warnings;

sub intersection {
    my ($arr1, $arr2) = @_;
    my %intersection;
    for my $i (@{$arr1}, @{$arr2}) {
        $intersection{$i}++;
    }

    return grep { $intersection{$_} > 1 } keys %intersection;
}

sub union {
    my ($arr1, $arr2) = @_;
    my %union;
    for my $i (@{$arr1}, @{$arr2}) {
        $union{$i}++;
    }
    return keys %union;
}

my %merges;

for my $arg (@ARGV) {
    my @temp = split /\s+/, $arg;
    my $name = shift @temp;
    push @{$merges{$name}}, [@temp];
}

for my $key (keys %merges) {
    for my $i (0 .. scalar @{$merges{$key}} - 2) {
        for my $j ($i + 1 .. scalar @{$merges{$key}} - 1) {
            if (scalar intersection(\@{$merges{$key}->[$i]}, \@{$merges{$key}->[$j]})) {
                @{$merges{$key}}[$i] = [ union(\@{$merges{$key}->[$i]}, \@{$merges{$key}->[$j]}) ];
                @{$merges{$key}}[$j] = [];
            }
        }
    }
}

my @output;
for my $key (keys %merges) {
    for my $value (@{$merges{$key}}) {
        if (scalar @{$value}) {
            push @output,
                q{[} .
                (join q{, }, map { q{"} . $_ . q{"} } ( $key, @{$value} )) .
                q{]};
        }
    }
};

say q{[ }, (join ",\n", sort { $a cmp $b } @output), q{ ]};
