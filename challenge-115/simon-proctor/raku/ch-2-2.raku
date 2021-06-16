#!/usr/bin/env raku

#|( Given a triangle of height $N return the possible routes from the top 
 To the bottom right
)
multi sub MAIN(UInt $N) {
    say traverse-triangle($N).join(", ");
}

multi sub MAIN("test") is hidden-from-USAGE {
    use Test;
    ok traverse-triangle(1) (==) <R LH>;
    ok traverse-triangle(2) (==) <RR LHR LHLH LLHH RLH LRH>;
}

sub traverse-triangle( $size ) {
    my %seen;
    my @routes = ["R" x $size];

    while (@routes) {
        my @promises;
        while (@routes && @promises.elems < 1000) {
            my $route = shift @routes; 
            next if %seen{$route};
            %seen{$route} = True;
            given $route {
                when /R/ {
                    @promises.push( start mod-right( $route ) );
                    proceed;
                }
                when /HL/ {
                    @promises.push( start mod-hl( $route ) );
                }
            }
        }

        await @promises;

        for (@promises) -> $p {
            for ( $p.result ) {
                @routes.push( $_ ) if ! %seen{$_} && ($_ !(elem) @routes);
            }
        }
        
        #note @routes.elems ~ ":" ~ @promises.elems ~ ":" ~ %seen.keys.elems;

    }
    

    return %seen.keys;
}

sub mod-right( Str $row ) {
    my @out;
    for (0..^$row.codes) -> $i {
        if ( $row.substr($i,1) eq "R" ) {
            @out.push( $row.substr(0,$i) ~ "LH" ~ $row.substr($i+1) );           
        }
    }
    return @out;
}

sub mod-hl( Str $row ) {
    my @out;
    for (0..^$row.codes-1) -> $i {
        if ( $row.substr($i,2) eq "HL" ) {
            @out.push( $row.substr(0,$i) ~ "R" ~ $row.substr($i+2) );
        }
    }
    return @out;
}