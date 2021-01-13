#!/usr/bin/perl
use 5.030;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <m> <n>
  
    <m>    range
    <n>    length of combination
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

if (scalar @ARGV < 2) {
    usage();
}

my ($m, $n) = @ARGV;

my @result = combinations([1 .. $m], $n);
say q{[ }, (join q{, }, map { q{[} . (join q{,}, @{$_}) . q{]} } @result), q{ ]};