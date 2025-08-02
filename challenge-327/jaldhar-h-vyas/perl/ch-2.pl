#!/usr/bin/perl
use 5.038;
use warnings;

sub combinations($listref, $length) {
    my @list = @{$listref};

    if ($length <= 1) {
        return map { [$_] } @list;
    }

    my @combos;

    for (my $i = 0; $i + $length <= scalar @list; $i++) {
        my $val  = $list[$i];
        my @rest = @list[$i + 1 .. $#list];
        for my $c (combinations(\@rest, $length - 1)) {
            push @combos, [$val, @{$c}] ;
        }
    }

    return @combos;
}

my @ints = @ARGV;
my %differences;

for my $pair (combinations(\@ints, 2)) {
    push @{ $differences{ abs($pair->[0] - $pair->[1]) } }, $pair;
}

say
join q{, },
sort
map { q{[} . ( join q{,}, sort { $a <=> $b } @{$_} ) . q{]} }
@{ $differences{ (sort { $a <=> $b } keys %differences)[0] } };
