#!/bin/env perl

use Modern::Perl;
use Getopt::Long;

no if $] >= 5.018, warnings => qw( experimental::smartmatch );

my $key = 'LEMON';
my $usage = <<USAGE;
$0 [--key <key>] encrypt plain-text
$0 [--key <key>] decrypt cipher-text
USAGE

GetOptions('key=s' => \$key);

unless (scalar @ARGV == 2) {
    print $usage;
    exit 1;
}

my @K = split //, uc($key);
my $i = 0;

given ($ARGV[0]) {
    when ('encrypt') {
        for my $p (split //, uc($ARGV[1])) {
            print char((offset($p) + offset($K[$i])) % 26);
            $i = ++$i % length($key);
        }
        say '';
    }
    when ('decrypt') {
        for my $c (split //, uc($ARGV[1])) {
            print char((offset($c) - offset($K[$i])) % 26);
            $i = ++$i % length($key);
        }
        say '';
    }
    default {
        print $usage;
        exit 1;
    }
}

sub offset { ord(shift)  - ord('A');  }
sub char   { chr((shift) + ord('A')); }
