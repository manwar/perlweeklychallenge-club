package My::List::Util;

use strict;
use warnings;
use feature qw'signatures';
no warnings qw'experimental::signatures';

use List::Util qw(any min);

use Exporter qw(import);

our @EXPORT_OK = qw(flatten zip zip_with chunks_of without);

# flatten : [[a]] -> [a]
sub flatten(@xs) {
    return map { @{$_} } @xs;
}

# zip : [a] -> [b] -> [[a,b]]
sub zip ( $as, $bs ) {
    return map { [ $as->[$_], $bs->[$_] ] } 0 .. min( $#{$as}, $#{$bs} );
}

# zip_with : (a -> b -> c) -> [a] -> [b] -> [c]
sub zip_with ( $fn, $as, $bs ) {
    return map { $fn->( $as->[$_], $bs->[$_] ) } 0 .. min( $#{$as}, $#{$bs} );
}

# splits a list into chunks of size $size
# chunks_of : Int -> [a] -> [[a]]
sub chunks_of ( $size, @xs ) {
    return if !@xs;
    my $chunk = [ @xs[ 0 .. min( ( $size - 1 ), $#xs ) ] ];
    return ( $chunk, chunks_of( $size, @xs[ $size .. $#xs ] ) );
}

# returns a list with all elements from a set are not in $bs.
# (Elements compared with string equality)
# without : [a] -> [a] -> [a]
sub without ( $as, $bs ) {
    grep {
        my $a = $_;
        !any { $_ eq $a } @$bs
    } @$as;
}
