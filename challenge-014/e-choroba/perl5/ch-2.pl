#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

my %states;
@states{qw(AL AK AZ AR CA CO CT DE DC FL GA HI ID IL IN IA KS KY LA ME
           MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI
           SC SD TN TX UT VT VA WA WV WI WY)} = ();

my $dictionary = '/usr/share/dict/british';
open my $in, '<', $dictionary or die $!;
my @longest = ("");
while (my $word = <$in>) {
    chomp $word;
    next if 1 & length $word;

    my $uc_word = uc $word;
    my @pairs = $uc_word =~ /\G(..)/g;

    next if grep ! exists $states{$_}, @pairs;

    next if length($word) < length $longest[0];

    if (length($word) == length $longest[0]) {
        push @longest, $word;
    } else {
        @longest = ($word);
    }
}
say for @longest;
