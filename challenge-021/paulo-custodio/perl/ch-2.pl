#!/usr/bin/perl

# Challenge 021
#
# Task #2
# Write a script for URL normalization based on rfc3986. This task was shared by
# Anonymous Contributor.
#
# According to Wikipedia, URL normalization is the process by which URLs are
# modified and standardized in a consistent manner. The goal of the
# normalization process is to transform a URL into a normalized URL so it is
# possible to determine if two syntactically different URLs may be equivalent.

use strict;
use warnings;
use 5.030;

sub decode_triplets {
    my($hex) = @_;
    my $c = chr(hex($hex));
    return $c if $c =~ /[a-zA-Z0-9\-._~]/;
    return '%'.uc($hex);
}

sub norm_uri {
    my($uri) = @_;
    for ($uri) {
        # Converting percent-encoded triplets to uppercase
        s/(\%[0-9a-f]{2})/\U$1/gi;

        # Converting the scheme and host to lowercase
        s/^(\w+:\/\/)((.*?@)?)(.*?\/)/\L$1\E$2\L$4/;

        # Decoding percent-encoded triplets of unreserved characters
        s/(\%([0-9a-f]{2}))/ decode_triplets($2) /gie;

        # Removing dot-segments
        s/\/\.\//\//g;
        s/\/[^\/]+\/\.\.\//\//g;

        # Converting an empty path to a "/" path
        s/^(\w+:\/\/[^\/]+)$/$1\//;

        # Removing the default port
        s/^(http:\/\/[^\/]+?):80\//$1\//;
    }
    return $uri;
}

my $uri = shift;
say norm_uri($uri);
