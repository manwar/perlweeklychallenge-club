#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl < input-file
#

use Getopt::Long;
GetOptions ('t'  =>  \my $to_base,
            'f'  =>  \my $from_base);

die "Need exactly one of -t or -f" unless $to_base xor $from_base;

my $BASE = 35;

my @digits = (0 .. 9, 'A' .. 'Y');
my %to;
@to {keys @digits} = @digits;
my %from = reverse %to;


sub to_base ($number) {
    my $out = "";
    while ($number) {
        $out    = $to {$number % $BASE} . $out;
        $number = int ($number / $BASE);
    }
    $out || "0";
}

sub from_base ($number) {
    my $out = 0;
    while (length $number) {
        my $digit = substr $number, 0, 1, "";
        $out *= $BASE;
        $out += $from {$digit};
    }
    $out;
}

while (my $number = <>) {
    chomp $number;
    say $to_base ? to_base $number : from_base $number
}

__END__
