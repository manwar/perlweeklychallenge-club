#!/usr/bin/perl
use 5.030;
use warnings;

sub invalid {
    say -i;
    exit;
}

my $size = shift;
my @list = @ARGV;

unless (scalar @list % $size == 0) {
    invalid;
}

my %frequency;
for my $i (@list) {
    $frequency{$i}++;
}

my @numbers = sort { $a <=> $b } keys %frequency;
my @results;
my $length = scalar @list / $size;

for (1 .. $length) {
    my @group;
    my $start = 0;

    for my $i (@numbers) {
        if ($frequency{$i} > 0) {
            $start = $i;
            last;
        } 
    }

    if (!$start) {
        invalid;
    }

    for my $i ($start .. $start + $size - 1) {
        if (!exists $frequency{$i} || $frequency{$i} == 0) {
            invalid;
        } 

        push @group, $i;
        $frequency{$i}--;
    }

    push @results, \@group;
}

say join q{, }, map { q{(} . ( join q{, }, @{$_} ) . q{)} } @results;
