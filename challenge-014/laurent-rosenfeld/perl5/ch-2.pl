#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

my %codes = map { $_ => 1 } qw /
    AL AK AZ AR CA CO CT DE FL GA
    HI ID IL IN IA KS KY LA ME MD
    MA MI MN MS MO MT NE NV NH NJ
    NM NY NC ND OH OK OR PA RI SC
    SD TN TX UT VT VA WA WV WI WY /;

sub valid {
    my $word = uc shift;
    for my $letter_pair ( $word =~ /\w\w/g ) {
        return 0 unless defined $codes{$letter_pair};
    }
    return 1;
}

my $longest_word = "";
my $max_size = 0;
my $dict = "words.txt";
open my $IN, "<", $dict or die "Unable to open $dict $!";
while (my $word = <$IN>) {
    $word =~ s/[\n\r]+//g;
    next if length($word) % 2;  #skip if odd length
    $longest_word = $word and $max_size = length $word
        if valid $word and length $word > $max_size;
}
say $longest_word;
