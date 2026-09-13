#!/usr/bin/perl
use 5.40.1;
use warnings;

my ($str) = @ARGV;
my @counts;
my @parts = (q{});
my $count = q{};

for my $c (split //, $str) {
    if ($c =~ /\d/) {
        $count .= $c;

    } elsif ($c eq q{[}) {
        push @counts, $count;
        push @parts, q{};
        $count = q{};

    } elsif ($c eq q{]}) {
        my $part = pop @parts;
        my $repeat = pop @counts;
        $parts[-1] .= $part x $repeat;

    } else {
        $parts[-1] .= $c;
    }
}

say $parts[0];
