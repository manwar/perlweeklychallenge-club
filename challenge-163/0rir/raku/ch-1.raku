#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.d;

=begin comment
Task 1: Sum Bitwise Operator
    Given a list positive numbers, calculate the sum of bitwise-and
    operations on all unique pairs.  NOTE:  Presuming position is not
    part of identity.
=end comment

my @n = ( 1, 2, 3, 8+2 );

say present-sumbit( @n );

exit;

# sumbit -- compute the sum per comment above.
# Operators with names this long are a bad idea, but the task's name
# implies an operator so:
sub prefix:<sumbit>( @a --> Int ) {         # The sumbit!
    my @dyad = cross( @a);
    @dyad = @dyad.flat[*;*];
    my $return = 0;
    for @dyad -> $d {
        $return += @$d[0] +& @$d[1];
    }
    $return
}

# generate all pairs of @a's elements and the empty pair.
sub cross( @a is copy --> Array ) {             # Lib-able?
    (my @dyad).append: gather while @a {
        my $e = @a.shift;
        my @l = $e X @a;
        take @l;
    }
}

sub present-sumbit( @a is copy --> Str) {
    die 'Arg @array must equal @array.unique' if @a !~~ @a.unique;
    die 'Arg @array must contain all positive integers'
        unless @a.all ~~ (Int) and @a.all > 0;

    my (@just, @ify );
    my $result = sumbit @a;
    my $return = 'Input: @n = ' ~ "( " ~ @a.List().join(', ')
        ~ ")\nOutput: " ~ $result ~  "\n\n";

    @just = cross( @a);
    @just = @just.flat[*;*];

    for @just -> $e is rw {
        @ify.push: @$e[0] +& @$e[1];
        $e = '(' ~ @$e[0] ~ ' +& ' ~ @$e[1] ~ ')';
    }
    $return ~= 'Since ' ~ @just.join( ' + ')
              ~ ' => ' ~ @ify.join( ' + ') ~ " => $result.";
}
