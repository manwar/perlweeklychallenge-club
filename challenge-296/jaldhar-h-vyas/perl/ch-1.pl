#!/usr/bin/perl
use v5.38;
use English;
use Getopt::Std;

sub usage {
    print <<"-USAGE-";
Usage:
  $PROGRAM_NAME -d <Str>
  $PROGRAM_NAME -e <Str>

    -d <Str>    decode a run-length encoded string
    -e <Str>    run-length encode a string
-USAGE-

    exit(1);
}

our($opt_d, $opt_e);

getopts('d:e:');

if (defined $opt_d) {
    $opt_d =~ s/(\d+)(.)/$2 x $1/ge;
    say $opt_d;
} elsif (defined $opt_e) {
    $opt_e =~ s/((.)\g2+)/(length $1) . $2/ge;
    say $opt_e;
} else {
    usage();
}