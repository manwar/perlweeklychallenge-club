#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <column>
  $PROGRAM_NAME <num>
  
    <column>    string of capital letters only
    <num>       integer > 0
-USAGE-
    exit 0;
}

sub columnToNum {
    my ($column) = @_;
    my @chars = reverse split //, $column;
    my $output = 0;

    for my $i (0 .. scalar @chars - 1) {
        $output +=
            (ord($chars[$i]) - ord('A') + 1) * 26 ** $i;
    }
    return $output;
}

sub numToColumn {
    my ($num) = @_;
    my $output = 'A';

    for (1 ..  $num - 1) {
        $output++;
    }
    return $output;
}

my $arg = shift // usage();

if ($arg =~ /^[A-Z]+$/) {
    say columnToNum($arg);
} elsif ($arg =~ /^[0-9]+$/ && $arg > 0) {
    say numToColumn($arg);
} else {
    usage();
}
