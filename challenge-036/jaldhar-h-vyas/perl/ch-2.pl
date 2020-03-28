#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

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

my @boxes = (
    { name => 'R', weight => 1,  amount => 1  },
    { name => 'B', weight => 1,  amount => 2  },
    { name => 'G', weight => 2,  amount => 2  },
    { name => 'Y', weight => 12, amount => 4  },
    { name => 'P', weight => 4,  amount => 10 },
);

for my $i (2 .. 5) {
    my $max = { name => q{}, weight => 0, amount => -1 };

    for my $combo (combinations(\@boxes, $i)) {
        my $total = { name => q{}, weight => 0, amount =>  0 };
        for my $box (@{$combo}) {
            $total->{name}   .= $box->{name};
            $total->{weight} += $box->{weight};
            $total->{amount} += $box->{amount};
        }
        if ($total->{weight} <= 15 && $total->{amount} > $max->{amount}) {
            $max = $total;
        }
    }
    if ($max->{amount} > -1) {
        say "For $i boxes, the best combination is $max->{name} which weighs ",
            "$max->{weight} kg and is valued £$max->{amount}.";
    } else {
        say "for $i boxes, it is not possible to meet the criteria.";
    }
}