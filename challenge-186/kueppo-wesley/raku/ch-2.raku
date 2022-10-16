#!/usr/bin/env raku

sub makeover( $string ) {
	NFKD( $string ).map( { .chr.encode('ascii', :replacement('')).decode('ascii') } ).join().say;
}

makeover( "ÃÊÍÒÙ" );
makeover( "âÊíÒÙ" );
