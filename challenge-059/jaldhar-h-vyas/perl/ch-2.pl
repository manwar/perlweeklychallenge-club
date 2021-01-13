#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME [<ARGS> ...]
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

sub f {
    my ($a, $b) = @_;
    my $c = 0 + sprintf("%b", $a);
    my $d = 0 + sprintf("%b", $b);

    if (length $c > length $d) {
        $d = sprintf("%0*d", length $c, $d);
    } elsif (length $d > length $c) {
        $c = sprintf("%0*d", length $d, $c);
    }
    return ($c ^ $d) =~ tr/1/1/;
}

if (scalar @ARGV < 1) {
    usage();
}

my $total = 0;

for my $a (combinations(\@ARGV, 2)) {
    $total += f($a->[0], $a->[1]);
}

say $total;
 