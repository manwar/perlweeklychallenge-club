#!raku

#
# Perl Weekly Challenge 203
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-203/>
#

sub MAIN( $src, $dst ) {
    exit if ! $src.IO.d;
    exit if ! $dst.IO.d;

    for $src.IO.dir( test => { ( $src.IO.absolute ~ "/$_" ).IO.d } ) -> $dir {
	# skip . and .. directories
	next if $dir ~~ / ^ \. ** 1..2  $ /;
	$dst.IO.mkdir( $dir.basename );
    }
}
