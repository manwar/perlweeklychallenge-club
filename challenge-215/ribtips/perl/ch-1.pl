#!/usr/bin/perl

use strict;
use warnings;

&main;

sub main {
    my @words=('abc','xyz','tsu');
    &process_list(\@words);
    my @words=('rat','cab','dad');
    &process_list(\@words);
    my @words=('x','y','z');
    &process_list(\@words);
}

sub process_list {
    my $array=shift;
    my $output=0;
    foreach my $word (@$array) {
        $output+=&sort_string(\$word);    
    }
    print "Output: $output\n";
}

sub sort_string {
    my $word=shift;
    my $sorted=join "", sort split //,$$word;
    if ($sorted eq $$word) {
        return(0);
    }
    else {
        return(1);
    }
}
