use strict;
use warnings;

use v5.20;

package HashCounting;

use base qw( Exporter );

our @EXPORT_OK = qw( h );

use feature qw( signatures );
no warnings qw( experimental::signatures );

sub h( $c, $s = '', $n = $c ) {

    return $s if $c < 1;

    $s = substr "$c#$s", -$n;
    @_ = ( $n - length( $s ), $s, $n );

    goto __SUB__
}

1
