#!/usr/bin/env raku
# Happy Numbers
# Find the first 8 Happy Numbers in base 10.
# https://en.wikipedia.org/wiki/Happy_number
# This script also outputs _all_ the Happy and Sad numbers found,
#  not just the first n = 8.

my %happy;
my %sad;

sub MAIN( Int $n = 8 ){
    for (1 ... *) -> $i {
        my @happy =  %happy.keys.map({$_.Int}).sort;
        my @sequential = @happy.grep( { $_ <= $i} );
        if @sequential.elems >= $n {
            say "First $n Happy Numbers:";
            say @sequential;
            last;
        }
        is-happy( $i );
    }
    
    say "All Happy Numbers Found:";
    say %happy.keys.map({$_.Int}).sort;
    say "All Sad Numbers Found:";
    say %sad.keys.map({$_.Int}).sort;
}

sub is-happy( $l, :%seen? ){
    my $sum = 0;
    for ($l.Str.split('')) -> $m {
        $sum += $m**2;
        %seen{ $l } = 1;
    }
    if ( defined %happy{ $sum } or $sum == 1 )
        {
            for keys %seen -> $k { %happy{ $k } = 1 };
        }
    elsif ( defined %sad{ $sum } or defined %seen{ $sum } )
        {
            for keys %seen -> $k { %sad{ $k } = 1 };
        }
    else
        {
            %seen{ $sum } = 1;
            is-happy( $sum, seen => %seen );
        }
}
