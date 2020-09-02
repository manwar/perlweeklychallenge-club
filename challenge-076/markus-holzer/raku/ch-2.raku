unit sub MAIN( $fw, $fb );

my @w = $fw.IO.lines.sort;
my @b = $fb.IO.lines( :chomp( False ) ).map: *.subst(' ', '', :g);
my $c = @b.first.chars;
my @c = @b.map( |*.comb );

.say for map { | f r $_ }, 0, 90, 45, -45;

multi r(   0 ) { @c.batch( $c ) }
multi r(  90 ) { r 0, 0, 0 }
multi r( -45 ) { r 0, 1, 0 }
multi r(  45 ) { r 1, 0, 1 }
multi r( $i, $j, $o ) {
    map { @c[ $_ + $o, ( $_ + $c + $j ) ... * ] }, ^$c - $i }

sub f( @b ) {
    gather for @b>>.join -> $b {
        for $b, $b.flip -> $l {
            for $l ~~ m:ex:i/ @w / {
                take ~$_  }}}}