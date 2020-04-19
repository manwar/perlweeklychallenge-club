#!/usr/bin/env perl

# use v5.24;
use strict;
use Data::Dumper;

binmode STDOUT, ":utf8";

my $sum_ok = 22;

sub preorder($$) {
    my $t = shift or return;
    my @path = @{+shift};
    
    push @path, $t->[0];

    if ( ! $t->[1]  && ! $t->[2] ) { # Is a leaf
        my $sum = 0;
        for(@path) {$sum += $_; }
        my $path = join ' '.chr(0x2794).' ', @path;
        my $ok = $sum == $sum_ok ? chr(0x221A) : chr(0x2022);
        printf "$ok sum [$sum] for path: $path\n";
        
    } else {
        preorder($t->[1], \@path); # if $t->[1];
        preorder($t->[2], \@path); # if $t->[2];
    }

}

# [Node-Left-Right]
my $tree = [ 5, [ 4, [ 11, [7], [2] ] ], [ 8, [13], [ 9, [1] ] ] ];

#print Dumper($tree);

preorder($tree, []);

