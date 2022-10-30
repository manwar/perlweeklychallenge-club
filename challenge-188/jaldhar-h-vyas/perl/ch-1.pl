#!/usr/bin/perl
use 5.030;
use warnings;
use English;

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

sub usage {
print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <k> [<list> ...]
  
    <k>             divisor
    [<list> ...]    list of integers
-USAGE-
    exit(0);
}

unless (@ARGV) {
    usage;
}

my $k = shift;
my @list = @ARGV;

say scalar grep { ($list[$_->[0]] + $list[$_->[1]]) % $k == 0; }
    combinations([0 .. scalar @list - 1], 2);
