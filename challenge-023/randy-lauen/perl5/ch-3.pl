#!/usr/bin/env perl

=head2 SYNOPSIS

Task:
Write a script to use Random Poems API.

Usage:
    $ perl ch-3.pl

Notes:
This script prints the shortest poem returned by the randompoems endpoint.
The Poemist API docs are located here: https://poemist.github.io/poemist-apidoc/

=cut

use v5.28;
use strict;
use warnings;

use JSON qw( decode_json );
use List::UtilsBy qw( nsort_by );
use Net::Curl::Simple ();

binmode(STDOUT, "encoding(UTF-8)");

my $curl = Net::Curl::Simple->new();
$curl->get( 'https://www.poemist.com/api/v1/randompoems' );

my ($poem) = 
    nsort_by { length( $_->{content} ) }
    map { $_->@* }
    decode_json( $curl->content )
;

say qq["$poem->{title}" by $poem->{poet}->{name}];
say '';
say $poem->{content};
say '';
say $poem->{url};

exit 0;


