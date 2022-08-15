#!/usr/bin/perl
use 5.030;
use warnings;
use English qw/ -no_match_vars /;
use Getopt::Std;

sub checkdigit {
    my ($n) = @_;
    my @digits = split //, $n;
    my $interim = 0;

    for my $i (@digits) {
        $interim = lookup($i, $interim);
    }

    return $interim;
}

sub lookup {
    my ($col, $row) = @_;

    my @table = (
        [ 0, 3, 1, 7, 5, 9, 8, 6, 4, 2 ],
        [ 7, 0, 9, 2, 1, 5, 4, 8, 6, 3 ],
        [ 4, 2, 0, 6, 8, 7, 1, 3, 5, 9 ],
        [ 1, 7, 5, 0, 9, 8, 3, 4, 2, 6 ],
        [ 6, 1, 2, 3, 0, 4, 5, 9, 7, 8 ],
        [ 3, 6, 7, 4, 2, 0, 9, 5, 8, 1 ],
        [ 5, 8, 6, 9, 7, 2, 0, 1, 3, 4 ],
        [ 8, 9, 4, 5, 3, 6, 2, 0, 1, 7 ],
        [ 9, 4, 3, 8, 6, 1, 7, 2, 0, 5 ],
        [ 2, 5, 8, 1, 4, 3, 6, 7, 9, 0 ],
    );

    return $table[$row]->[$col];
}

sub usage {
    print<<"-usage-";
Usage:
  $PROGRAM_NAME -c <n>
  $PROGRAM_NAME -v <n>
  
    <n>    a number
    -c     compute checksum
    -v     validate checksum
-usage-
    exit 0;
}

our ($opt_c, $opt_v);

getopts("c:v:");

if (defined $opt_c) {
    my $n = $opt_c;

    say $n, checkdigit($n);
} elsif (defined $opt_v) {
    my $n = $opt_v;

    say checkdigit($n) == 0 ? 1 : 0;

} else {
    usage();
}
