#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub pick {
    my @list = @{$_[0]};
    my $length = scalar @list;
    my $n = $_[1] // 1;
    my @picked;

    while (scalar @picked != $n) {
        my $pos = int(rand($length));
        if (defined $list[$pos]) {
            push @picked, $list[$pos];
            $list[$pos] = undef;
        }
    }

    return wantarray ? @picked : $picked[0];
}

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <N>

    <N>    > 1
-USAGE-
    exit 0;
}

my $N = shift // usage();
if ($N < 2) {
    usage();
}

my @arr = pick([1 .. 50], $N);
my @peak;

for my $i (0 .. (scalar @arr - 1)) {
    if ($arr[$i] > ($arr[$i - 1] // 0) && $arr[$i] > ($arr[$i + 1] // 0)) {
        push @peak, $arr[$i];
    }
}
say 'array: ', (join q{, }, @arr);
say 'Peak: ', (join q{, }, @peak);
