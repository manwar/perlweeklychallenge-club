#!/usr/bin/env raku

use v6;

#| Print the 20 longest Collatz chain for values up to 1000000
multi sub MAIN( Bool :v(:$verbose)=False){
    constant MAX-VALUE = 1000000;
    
    my \batch-size = MAX-VALUE div 10;

    my @promises;
    my $start = 1;
    
    for (1..10) {
        my $s = $start;
        my $e = $start+batch-size-1;
        @promises.push( start chain-batch($s,$e,$verbose) );
        $start+=batch-size;
    }

    await @promises;
    
    my @largest = @promises.map( |*.result ).sort({$^b.elems <=> $^a.elems}).[^20]; 

    .say for @largest.map( { "{$_.join("->")} : {$_.elems} steps" } );    
}

multi sub chain( 1 ) { 1 }
    
multi sub chain( UInt \n where { n %% 2 } ) is pure { ( n, |chain( n div 2 ) ); }

multi sub chain( UInt \n where { n !%% 2 && n > 1 } ) is pure { ( n, |chain( (3 * n) + 1 ) ); }


sub chain-batch( UInt $start is copy, UInt $end is copy, Bool \verbose ) {
    my @largest = [];
    my $shortest = 0;

    say "got {$start} to {$end}" if verbose;
    
    for ($start..$end).reverse -> \val {
        my $collatz = chain(val);
        if $collatz.elems >= $shortest {
            @largest = @largest.push($collatz).sort( { $^b.elems <=> $^a.elems} ).[^20].grep(*.defined);
            if @largest.elems == 20 {
                $shortest = @largest[*-1].elems;
            }
        }
        say "{val} : {$collatz.elems} : $shortest" if verbose;
    }

    return @largest;
}
