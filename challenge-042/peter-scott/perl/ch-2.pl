#!/usr/bin/env perl
use 5.016;

my ($MIN_STR_LEN, $MAX_STR_LEN) = (4,10);
my $string_length = int( rand( $MAX_STR_LEN - $MIN_STR_LEN ) ) + $MIN_STR_LEN;
my $string = '';
$string .= @{[qw{ ( ) }]}[rand 2] for 1 .. $string_length;
print "$string - ";
1 while $string =~ s/\(\)//;
say $string ? "NOT OK" : "OK";
