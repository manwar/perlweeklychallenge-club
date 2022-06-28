#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;
use Test;

=begin comment
Task 2: First-class Function Submitted by: Mohammad S Anwar

Create sub compose($f, $g) which takes in two parameters $f and $g
as subroutine refs and returns subroutine ref i.e. compose($f, $g)->($x) = $f->($g->($x))
The argument functions both are variadic ( one to ∞ ).

After 'h = compose(f, g)' then
'f(g($x,$y, ... )) == h($x,$y, ...)' is True for any $x, $y, ...
=end comment

sub compose( &one, &two ) {
    sub ( *@a where @a[0].defined --> Array ) { one( two( @a )); }
}

sub twice ( *@a where @a[0].defined --> Array) { [ @a.map: * × 2  ]; }

sub incre( *@a is copy where @a[0].defined -->Array ) {
    @a[$_] = @a[$_] +1 for 0 .. @a.end ;
    @a;
}


my @test = [ 2, ], [ 2, 10], [ 0, 0], [ -2, -10, 100 ], [ -1, 1, 5, 9, 11, 15, 19, 23, 29];

my &both = compose( &twice, &incre) ;


plan 6 + @test.elems;

dies-ok { incre() }, 'incre requires arg dies';
dies-ok { twice() }, 'twice requires arg dies';
dies-ok { both() }, 'both requires arg dies';
is incre( 2, 10), [3, 11], 'incre( 2, 10)';
is twice( 2, 10), [4, 20], 'twice( 2, 10)';

is both(2, 10, 20, 30), twice(incre(2, 10, 20, 30 )),
    "both( 2, 10, 20, 30) ==> " ~ both( 2, 10, 20, 30) ~ ' hand';

for @test -> @t {
    is both(@t), twice(incre( @t )), "both( @t[]) ==> " ~ both( @t);
}
done-testing;
