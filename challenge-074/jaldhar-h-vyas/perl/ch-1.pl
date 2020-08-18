#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {

    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME [<A> ...]

    [<A> ...]    list of integers
-USAGE-

    exit 0;
}

my @A = @ARGV;
if (!scalar @A) {
    usage();
}

my %count;
map { $count{$_}++; } @A;
my $N = int (scalar @A / 2);

my @majority = grep { $count{$_} > $N; } keys %count;

if (!scalar @majority) {
    @majority = (-1);
}

say join q{ }, @majority;