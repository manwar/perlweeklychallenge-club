#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print << "-USAGE-";
Usage:
  $PROGRAM_NAME <A> [<N> ...]
  
    <A>          difference between any pair from <N>
    [<N> ...]    array of integers
-USAGE-

    exit(0);
}

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

my $A = shift // usage();
my @N = @ARGV || usage();

say scalar(grep { abs($_->[0] - $_->[1]) == $A; } combinations(\@N, 2)) ? 1 : 0;