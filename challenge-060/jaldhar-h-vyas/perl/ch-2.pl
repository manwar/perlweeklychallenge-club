#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;
sub usage {
    say<<"-USAGE-";
  $PROGRAM_NAME <X> <Y> [<L> ...]

    <X>          number of digits in output numbers
    <Y>          output numbers must be less than this amount
    [<L> ...]    list of input numbers
-USAGE-
    exit 0;
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

my $X = shift // usage();
my $Y = shift // usage();
my @L = @ARGV;

my @output = map { (join q{}, @{$_}) + 0, (join q{}, reverse @{$_}) }
    combinations(\@L, $X);
push @output, map { ($_ x $X) + 0 } @L;

say join q{, }, (grep { length == $X && $_ < $Y } sort { $a <=> $b } @output);
