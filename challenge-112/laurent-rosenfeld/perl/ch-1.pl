use strict;
use warnings;
use feature "say";

my @tests = ('/a/', '/a/b//c/', '/a/b/c/../..', '/a/../../b/', '/a/././b/');
TEST: for my $path (@tests) {
    my $p = $path;
    $path =~ s|\/\/+|/|g;
    $path =~ s!^\/|\/$!!g;
    my @path_items;
    for my $item (split /\/+/, $path) {
        next if $item eq '.';
        if ($item eq '..') {
            warn "Invalid path $p" and next TEST unless @path_items;
            pop @path_items;
        } else {
            push @path_items, $item;
        }
    };
    say "$p => /", join '/', @path_items;
}
