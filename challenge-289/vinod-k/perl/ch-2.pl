#!/usr/bin/perl
use strict;
use warnings;
use List::Util qw/ shuffle /;

my $string = "Larry wall developed Perl";

my @str_array = split /(\s+)/, $string;
my @final_str;
my $s;

foreach my $word( @str_array ){
    if (length($word) > 4 && $word !~ /[,.]/){
        my @words = split //, $word;
        $s = join '', $words[0], shuffle(@words[1..$#words-1]), $words[-1];
        push (@final_str, $s);
    } else {
        push (@final_str, $word);
    }
}

print join("", @final_str)."\n";

