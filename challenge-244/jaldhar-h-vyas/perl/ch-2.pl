#!/usr/bin/perl
use 5.030;
use warnings;

sub combinations {
    my @list = @{$_[0]};
    my $length = $_[1];

    if ($length <= 1) {
        return map [$_], @list;
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

sub power {
    my ($arr) = @_;
    my @sorted = sort { $a <=> $b } @{$arr};

    return $sorted[-1] ** 2 * $sorted[0];
}

sub sum {
    my ($arr) = @_;
    my $total = 0;

    for my $elem (@{$arr}) {
        $total += $elem;
    }

    return $total;
}

my @nums = @ARGV;
my $total = 0;

for my $i (1 .. scalar @nums) {
   $total += sum([ map { power($_) } combinations(\@nums, $i) ]);
}

say $total;
