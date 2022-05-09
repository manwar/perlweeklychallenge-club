#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.d;

=begin comment

2: Summations
    Given a list of numbers.  Make a tempory list by snipping off the first
    item.  Create the next list from the temporary by having each number be
    the sum of the temporary's items which are before or at the position of
    the item being calculated.  Dump the temporary list.  Repeat with the
    list just created until you have a single number.  An example leaving
    out the temporaries: (2,3,1) --> (  3,4) --> (    7).

    My terminology of 'final summation' or 'summation arrays' may
    be idiocyncratic.

=end comment

constant COL_WIDTH = 4;

# (),(1,),(1,2),(1,2,3),(1,2,3,4),(1,2,3,4,5),(1,2,3,4,5,6);

my @n = (1,5,4,3,2,6,7);
my @summation = create-summation-arrays( @n );
my $result = final-summation( @summation );

say 'Input: @n = ' ~ "( " ~ @n.List().join(', ')
        ~ ")\nOutput: " ~ $result ~  "\n";
display-summation( @summation );

exit;

sub display-summation( @ary --> Nil ) {
    my $ct =0;
    my $fld-width = COL_WIDTH;
    for @ary -> @a {
        print ' ' x ($ct * $fld-width);
        for @a -> $fld {
            printf "%$($fld-width)s", $fld;
        }
        ++ $ct;
        print "\n";
    }
}

sub create-summation-arrays( @ary-pos-int --> Array ) {
    my @current = @ary-pos-int;
    (my @return).push: @ary-pos-int ;

    while @current.end > 0 {
        my @tmp;
        for 1 .. @current.end -> $i {
            @tmp.push:  [+] @current[1 ... $i];
        }
        @return.push: @tmp;
        @current = @tmp;
    }
    @return;
}

sub final-summation( @AoSummation ) { return @AoSummation[*-1][0]; }

