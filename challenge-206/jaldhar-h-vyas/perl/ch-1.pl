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

my @times = map {
        my ($h, $m) = split /\:/, $_;
        ($h == 0 && $m == 0 ? 1440 : $h * 60) + $m; 
    } @ARGV;

say 0+(sort { $a <=> $b } map { abs (@$_[0] - @$_[1]) } combinations(\@times, 2))[0];
