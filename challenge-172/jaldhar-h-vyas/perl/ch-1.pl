#!/usr/bin/perl
use 5.030;
use warnings;
use English qw/ -no_match_vars /;

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

sub isPrime {
    my ($n) = @_;

    if ($n < 2) {
        return undef;
    }

    if ($n == 2) {
        return 1;
    }

    for my $i (2 .. sqrt($n)) {
        if ($n % $i == 0) {
            return undef;
        }
    }

    return 1;
}

sub sum {
    my ($arr) = @_;
    my $total = 0;

    for my $elem (@{$arr}) {
        $total += $elem;
    }

    return $total;
}

sub usage {
print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <m> <n>
  
    <m>    an integer to partition
    <n>    number of elements in partition
-USAGE-
    exit(0);
}

if (scalar @ARGV != 2) {
    usage();
}

my ($m, $n) = @ARGV;

my @primes = grep { isPrime($_) } 1 .. $m;
my $count = 0;

for my $combo (combinations(\@primes, $n)) {
    if (sum($combo) == $m) {
        say join q{, }, @{$combo};
        $count++;
    }
}

unless ($count) {
    say "No such prime partition.";
}
