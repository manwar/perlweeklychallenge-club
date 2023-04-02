#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.e.PREVIEW;
use experimental :macros;
use Test;

constant DEBUG = 0;

=begin comment
210-2: Number Collision         Submitted by: Mohammad S Anwar
Given an array of integers which can move in right direction if it is positive and left direction when negative. If two numbers collide then the smaller one will explode. And if both are same then they both explode. We take the absolute value in consideration when comparing.

All numbers move at the same speed, therefore any 2 numbers moving in the same direction will never collide.

Write a script to find out who survives the collision.

Example 1:
Input: @list = (2, 3, -1)
Output: (2, 3)

The numbers 3 and -1 collide and -1 explodes in the end. So we are left with (2, 3).
Example 2:
Input: @list = (3, 2, -4)
Output: (-4)

The numbers 2 and -4 collide and 2 explodes in the end. That gives us (3, -4).
Now the numbers 3 and -4 collide and 3 explodes. Finally we are left with -4.
Example 3:
Input: @list = (1, -1)
Output: ()

The numbers 1 and -1 both collide and explode. Nothing left in the end.
=end comment


my @Test =
        # examples
    [ 2,3,-1],              [ 2,3, Any],
    [ 3,2,-4],              [ Any,Any,-4],
    [ 1,-1],                [ Any,Any],
        # shorted
    [ ],                    [ ],
    [ 1,],                  [ 1,], 
    [ -1],                  [ -1,], 
    [ -1,-2],               [ -1,-2], 
    [ 1,2],                 [ 1,2], 
    [ 0,1,2],               [ 0,1,2], 
    [ -1,-2,-3],            [ -1,-2,-3],
    [ -1,-2,-1,0,5,10,0],   [ -1,-2,-1,0,5,10,0],
        # 
    [ -1,1,],               [ -1,1,],
    [ -1,0,1,],             [ -1,0,1,],
    [ -1,-1,0,1,1,],        [ -1,-1,0,1,1,],
    [ -1,-1, 0,-1, 1,1 ],   [ -1,-1,Any,-1,1,1 ],
    [ -1,0,1,2,3,4,5],      [ -1,0,1,2,3,4,5], 
    [ 2,2,2,-3],            [ Any,Any,Any,-3],
    [1,-2],                 [ Any,-2],
    [2,-1],                 [ 2,Any],
    [5,2,-3,2,-3,2,-3],     [ 5,Any,Any,Any,Any,Any,Any],
    [5,2,-3,2,-3,2,-3,5],   [ 5,Any,Any,Any,Any,Any,Any,5],
    [5,2,-3,2,4,-3,2,-3,5], [ 5,Any,Any,2,  4,  Any,Any,Any,5],
    [0,0,2,-2,3,-3,0,-0],   [ 0,0,  Any,Any,Any,Any,0, -0]
;

plan @Test ÷ 2;

sub pos( $n) {        0 ≤ $n         }

#sub is-partitioned-neg-pos( @a) {
#    my &pred = -> $_ { .[0] < 0 };
#    @a.&{$_ Z .skip}.map({ (( $_ < 0) & !( $_ < 0 )) }).sum <= 1
#}
#sub is-partition-w-first( @a) {
#    @a.first({$_ < 0},:k,:end) < @a.first({$_ ≥ 0},:k);
#}

sub int-whack-an-int( Int @ar --> Array) {
    die "Type objects are illegal: @ar.raku()" if @ar.any === Int;
    return @ = @ar  if @ar     ~~ []
                    or @ar.end == 0
                    or @ar.max  < 0
                    or @ar.min  ≥ 0
                    or @ar.first({$_ < 0},:k,:end) < @ar.first({$_ ≥ 0},:k)
    ;

    # state variables
    my @a = @ar;
    my $l;
    my $r;

    my &STAT = sub ($k) {;}
    if DEBUG { &STAT = &stat} 

    my %Xition =
        'Start'  => -> { $l=0, $r=1; 'DoneQ'; },
        'ValidQ' => -> { STAT "VQ"; 
            # possibles: two-values, ; one-value, no-value, 
                defined(@a[$l,$r].all) ?? 'EvalQ' !! 'DoneQ' 
            },
        'EvalQ'     => -> { STAT 'EQ'; ( pos(@a[$l]) <=> pos(@a[$r])).Str },
        'Less'      => -> { STAT 'Ls'; $l = $r++; 'DoneQ' },
        'Same'      => -> { STAT 'Sa'; $l = $r++; 'DoneQ' },
        'More'      => -> { STAT 'Mo';
                     ( @a[$l].abs <=> @a[$r].abs ).Str ~ 'Abs'; },
        'LessAbs'   => -> { STAT 'LsA';
                        @a[$l] = Nil; 
                        $l = @a[^$l].first( Nil !~~*,:k,:end) // $r;
                        if $l == $r {
                            ++$r;
                            'DoneQ';
                        } else {
                            'ValidQ';
                    }   },
        'SameAbs'   => -> { STAT 'SaA';
                        @a[$l] = @a[$r] = Nil;
                        ++$r;
                        $l = @a[^$l].first( .defined, :k, :end) // $r; 
                        $r =   $l < $r ?? $r !! $r+1;
                        'DoneQ';
                     },
        'MoreAbs'   => -> { STAT 'MoA';
                        @a[$r] = Nil;
                        $r++;
                        'DoneQ';
                    },
        'DoneQ'  => -> { STAT 'DQ'; $r > @a.end ?? 'Done' !! 'ValidQ'},
        'Done'   => 'End state.',
    ;

    my $state = 'Start';
    while $state ne 'Done' { $state = %Xition{$state}() }

    @a.=grep: *.defined;
    return @a;

            # not reached

    sub stat( $k ) {
         state $n;
         say ++$n,": $k: \@a[$l,$r]: @a[$l,$r].raku() @a: @a.raku()";
         exit if $n == 0;
    }
}

for @Test -> @proto-in, @exp {
    my Int @in = @proto-in.map( *.Int);
    @exp.=grep: *.defined;
    is-deeply int-whack-an-int( @in), @exp, "@in[] --> @exp.raku()";
}
done-testing;
my Int @list = (5,2,-3,2,-3,2,-3,5);

say "\nInput: @list = (", @list.join( ', '), ")\nOutput: ",
        int-whack-an-int( @list);

exit;

