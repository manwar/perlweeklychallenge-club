#!/usr/bin/perl
use 5.038;
use warnings;

my @codes = map { $_ =~ s/^ \' | \' $//gx; $_ } split /\s+/, $ARGV[0];
my @names = split /\s+/, $ARGV[1];
my @status = split /\s+/, $ARGV[2];
my @validity = ();

for my $i (keys @codes) {
    push @validity,
        $codes[$i] =~ /^[A-Za-z0-9_]+$/ &&
        (grep {$_ eq $names[$i]} qw/electronics grocery pharmacy restaurant/) &&
        $status[$i] eq 'true'
        ? 'true'
        : 'false'
    ;
}

say join q{ }, @validity;
