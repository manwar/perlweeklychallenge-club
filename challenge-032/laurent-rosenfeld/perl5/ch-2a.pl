#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

sub generate_chart {
    my %data = %{$_[0]};
    my ($max, $min);
    for my $key (keys %data) {
        ($max, $min) = ($data{$key}, $data{$key}) unless defined $max;
        $max = $data{$key} if $data{$key} > $max;
        $min = $data{$key} if $data{$key} < $min;
    }
    my $scale_factor = 10 / ($max - $min);
    for my $key (sort { $data{$b} <=> $data{$a} } keys %data) {
        printf "%15s | %s\n", $key, "#" x ($data{$key} * $scale_factor);
    }
}
my $data = { apple => 30, cherry => 60, banana => 10, pear => 40 };
generate_chart $data;
