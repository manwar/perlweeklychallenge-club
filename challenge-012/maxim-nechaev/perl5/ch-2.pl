#!/usr/bin/perl -w
use strict;
use feature 'say';
use List::Util qw/all/;

sub common_root {
    my ($sep, @paths) = @_;

    my $root = '';
    foreach my $part ( split $sep, $paths[0] ) {
	next unless $part;
	last unless all { m/^${root}${sep}${part}($sep|$)/ } @paths;
	$root .= $sep.$part;
    }
    return $root;
}

say common_root '/', ('/a/b/c/d', '/a/b/cd', '/a/b/cc', '/a/b/c/d/e');