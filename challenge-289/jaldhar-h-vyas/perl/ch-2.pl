#!/usr/bin/perl
use v5.38;
use List::Util qw/ shuffle /;

my $str = shift // die "Need a string\n";
$str =~ s/(\w)(\w+)(\w)/$1 . (join q{}, (shuffle split q{}, $2)) . $3/ge;
say $str;