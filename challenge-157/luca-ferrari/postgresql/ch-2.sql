CREATE SCHEMA IF NOT EXISTS pwc157;


CREATE OR REPLACE FUNCTION
pwc157.brazilian( int )
RETURNS int
AS $CODE$
use Math::Base::Convert;
use Syntax::Keyword::Try;

for my $base ( 2 .. $_[0] - 1 ) {
    elog( DEBUG, "Base $base " );
    try {
        my $bc = Math::Base::Convert->new( 10, $base );
        my $n = $bc->cnv( $_[0] );
        elog( DEBUG, "Converted value $_[0] -> $n in base $base" );
        my @digits = split( //, $n );
        my %symbols;
        for my $d (@digits) {
            $symbols{ $d }++;
        }

        my $seen = 0;
        for my $k ( keys %symbols ) {
          $seen++ if $symbols{ $k } > 0;
        }

        return 1 if $seen == 1;

    } catch {
        elog( DEBUG, "Exception");
        next;
    }

}

return 0;

$CODE$
LANGUAGE plperlu;
