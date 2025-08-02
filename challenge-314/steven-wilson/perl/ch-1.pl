#!/usr/bin/env perl

use v5.35;
use Test2::Bundle::More;
use List::Util qw/zip_shortest/;

sub equalStrings {
    my @strings = @_;
    my $count = 0;
    my @strings_split = map {  [split //, $_]  } @strings;
    for my $z (zip_shortest(@strings_split)){
        my %chars = map { $_ => 1 } @$z;
        if (keys %chars == 1){
            $count++;
        } else {
            last;
        }
    }
    my $operations = 0;
    if ($count != 0){
        for my $string (@strings){
            $operations += (length($string) - $count);
        }
    }
    $operations == 0 ? return -1 : return $operations;
}

is(equalStrings("abc", "abb", "ab"), 2, "Example 1");
is(equalStrings("ayz", "cyz", "xyz"), -1, "Example 2");
is(equalStrings("yza", "yzb", "yzc"), 3, "Example 3");

done_testing();
