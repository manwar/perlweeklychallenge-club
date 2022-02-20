#!/usr/bin/env
# :vim ft=raku sw=4 expandtab
use v6.d;
use Test;

constant TEST = True;

# Triangle Sum Path
constant indent = 18;

my @test = 
    [[ [1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8]], [1,3,2,0,2]],
    [[ [5], [2,3], [4,1,5], [0,1,2,3], [7,2,4,1,9]],  [5,2,1,0,1]],
    [[ [1], [2,3], [4,5,6], [7,8,9,0], [1,2,3,4,5],
        [6,7,8,9,0,1] ],                              [1,2,4,0,1,0]],
    [[ [1], [2,3], [4,5,6], [7,8,9,0], [1,2,3,4,5],
        [6,7,8,9,0,1], [2,3,4,5,6,7,9]],             [1,2,4,0,1,0,2]],
;

for @test[0][0] -> @t {
    triangle-sum( @t, indent);
}

exit unless TEST;

sub triangle-sum( @ary, $indent --> Array ) {
    my $indentation = $indent;

    t-valid( @ary) or die 'non-triangle';

    {
        $_ = @ary.raku;
        s:g/ ' ' //;
        s:g/ ',[' /, [/;
        s/'[['/[ [/;
        s/']]'/] ]/;

        say "Input: \$triangle = $_\n";
    }

    my @path;

    for @ary -> @a {
        print ' ' x $indentation, @a.split( ' '), "\n";
        --$indentation;
        @path.push( @a.min);
    }
    say "\nOutput: ", ([+] @path), "\n\nMinimum Sum Path = ",
        @path.join( ' + ' ), ' => ', [+] @path;

    @path;  # for tests
}

sub t-valid( @ary --> Bool ) {
    for 0 … @ary.end -> $ix {
        return False if @ary[$ix].elems ≠ $ix +1;
    }
    True;
}

plan @test.elems;
for @test -> @t {
    is-deeply triangle-sum( @t[0], indent), @t[1], 'path';
}
done-testing;
