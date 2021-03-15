#!/usr/bin/env raku

use v6;

#| Run the test	suite
multi sub MAIN( "test" ) {
    use Test;
    is( tight-factors(4), (2,2), "4 factors to 2 and 2" );
    is( tight-factors(12), (3,4), "12 factors to 3 and 4" );
    is( spiralize( [1,2,3,4] ), [[4,3],[1,2]], "4 long list" );
    is( spiralize( [1,2,3,4,5,6] ), [[6,5,4],[1,2,3]], "6 Long list" );
    is( spiralize( (1..12) ), [[9,8,7,6],[10,11,12,5],[1,2,3,4]], "12 Long list" );
    done-testing;
}

#| Given a list of items print them in a tight anti clockwise sprial
multi sub MAIN( *@items ) {
    my $width = @items.map( *.chars ).max;
    .say for spiralize( @items ).map( -> @l { @l.map( { sprintf("%{$width}s",$_ ) } ).join(" ") });
}

sub tight-factors(Int $len) {
    (1..$len div 2).grep( { $len %% $_ } ).map( { ($_, $len / $_ ) } ).sort( -> ($a,$b) { abs($a-$b) } ).first;
}

sub spiralize( @list ) {
    my ( $height, $width ) = tight-factors( @list.elems );
    my @out = [[Any xx $width] xx $height];
   
    my @current = [0,$height-1];
    my @direction = [1,0];
    
    for @list -> $val {
	@out[@current[1]][@current[0]] = $val;
	my @next = [ @current[0]+@direction[0], @current[1]+@direction[1] ];
	if @next[0] < 0 || @next[1] < 0 ||
	   (@out[@next[1]][@next[0]]:!exists) || (defined @out[@next[1]][@next[0]]) {
	    given @direction {
		when [1,0]  { @direction = [0,-1] }
		when [0,-1] { @direction = [-1,0] }
		when [-1,0] { @direction = [0,1] }
		when [0,1]  { @direction = [1,0] }
	    }
	}
	@current = [ @current[0]+@direction[0], @current[1]+@direction[1] ];
    }
    return @out;
}

