#!/usr/bin/perl

use strict;
use warnings;

my $msg = "Please provide parameter e.g. -d:27 or -n:AA\n";
my $arg = $ARGV[0];
die $msg unless defined $arg;

if ($arg =~ /^\-d\:(.*)$/) {
    print sprintf("%s => %s\n", $1, to_excel($1));
}
elsif ($arg =~ m/^\-n\:(.*)$/) {
    print sprintf("%s => %s\n", $1, from_excel($1));
}
else {
    print $msg;
}

sub from_excel {
    my ($name) = @_;

    my $i = 0;
    my $b = 26;
    my $d = 0;
    foreach my $c (split //, scalar(reverse(uc $name))) {
        $d += (ord($c) - ord("A") + 1) * ($b ** $i++);
    }

    return $d;
}

sub to_excel {
    my ($number) = @_;

    my $name = '';
    my @name = (0, 'A' .. 'Z');
    while ($number > 26) {
        my $i = int $number / 26;
        $name   .= $name[$i];
        $number -= ($i * 26);
    }
    $name .= $name[$number];

    return $name;
}
