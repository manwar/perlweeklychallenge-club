#!/usr//bin/perl

use strict;
use warnings;

my %domains = ();
while ( <> ) {
    chomp;
    my ( $mailbox, $domain ) = split( m/\@/ );
    push( @{ $domains{$domain} }, $mailbox );
}

my @sorted = ();
for my $domain ( sort( { lc( $a ) cmp lc( $b ) } keys( %domains ) ) ) {
    push( @sorted, map( {"$_\@$domain"} sort( @{ $domains{$domain} } ) ) );
}
print join( "\n", @sorted ) . "\n";
