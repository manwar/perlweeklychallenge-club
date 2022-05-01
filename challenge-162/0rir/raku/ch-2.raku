#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.d;

my constant TEST = False;

=begin comment

Task 2: Wheatstone-Playfair cryptography.

Uses the below grid.  The letter 'x' is used for 'padding' as described below.

---------+   To show the encrypting process, we use "dove error meet".
p l a y f|   A clear text 'j' is converted to an 'i': no change. Where a
i r e x m|   letter repeats consecutively, a pad is inserted between them.
b c d g h|   "dove erxror mexets".  Then split the text into two char
k n o q s|   groups: "do ve er xr or me xe t".  If the last group is
t u v w z|   short, we expeditiously add a pad: "do ve er xr or me xe tx"
---------+   From here, we use the grid and rules to encode.

The rules:
    1) When going off the edge of the grid, continue to the far edge.
    2) Vertical:  'cn' prescribes an upright line, so replace each by the
       letter below.  'cn' becomes 'nu'.  'kt' becomes 'tp' with rule 1.
    3) Horizontal:  'rx' prescribes a flat line, so replace each by the
       letter to the right.  'rx' becomes 'em'. 'bh' becomes 'cb' with
       rule 1.
    4) Rectangle: 'rq' prescribes a rectangle, so replace each by the
       letter on the same horizontal line over or under the char. So 'rq'
       becomes 'xn'.  'um' becomes 'zr'.
    5) Remove all white space.

So "dove error meet" is "ovadmxemeneixmiv".

Decryption is the reverse.

=end comment

###################################################### Set up.

my $cycle = 5;  # array size,  array-index-type parameter

my $padding = 'x';
my @crypt-key = < p l a y f i r e x m b c d g h k n o q s t u v w z >;

my @grid = @crypt-key.rotor( $cycle);

my %ch2grid;

for 0 .. @crypt-key.end -> $i {
   my $char = @crypt-key[$i];
   my $row = ($i ÷ $cycle).Int;
   my $col = $i % $cycle;
   @grid[$row][$col] = $char;

   %ch2grid{$char}<ROW> = $row;
   %ch2grid{$char}<COL> = $col;
}

###################################################### Support Classes

# TODO Rename role unsigned int with designated upper bound.
role Bounded[ $max] {
    has Int $.value is rw;

    method period(--> Int) { $max }
    method from-Int(--> Int) { … }
}

# TODO Rename:  Uint-ish of $cycle size.
class Uinto does Bounded[ $cycle ] {

    method Int( --> Int) { $.value.Int }
    method Str( --> Str) { $.value.Str }

    method from-Int( Int:D $i --> Uinto ) {
        Uinto.new( :value( $i % $cycle)) }
}

############################################################### MAIN()

sub MAIN() {
    return if TEST;
    say "\n    (These combine I and J, and use X as padding.)\n";

    my $clear = "hide the gold in the tree stump";
    my $encode = encrypt($clear);
    say "encrypt( \"$clear\")", " -> $encode";
    say "decrypt( \"$encode\") -> ", decrypt( $encode), "\n\n";

    $clear = "the weekly challenge";
    $encode = encrypt($clear);
    say "encrypt( \"$clear\") -> ", $encode,;
    say "decrypt( \"$encode\") -> ", decrypt( $encode);
}

######################################################################
############################################################## Testing
if TEST {
use Test;
    ######################################################## Test data

    # NOTE: Same logic in test & implementation...
    my @uinto-pos = $cycle «R%« ( 0 .. 10 );
    my @uninto-neg = $cycle «R%« ( -10 .. 0 );

    # NOTE: so these are sanity checks.  These require $cycle == 5.
    my @uinto5 =
        -6 => 4,   -5 => 0,   -4 => 1,   -3 => 2,
        -2 => 3,   -1 => 4,    0 => 0,    1 => 1,
        2 => 2,    3 => 3,    4 => 4,    5 => 0,
        6 => 1,    -10 => 0,  10 => 0;
    ;

    my @pairup =
        e =>    ['ex',],
        ex =>   ['ex',],
        ee =>   ['ex', 'ex'],
        're ed' => [ 're', 'xe', 'dx'],
        'dove error meet' => ['do','ve','xe','rx','ro','rm','ex','et', ]
    ;

    my @encoder =
        # clear    encoded     decoded
        "of" => 'sa' => 'of',
        'off' => 'sa my' => 'ofxf',
        'the' => 'zbxm' => 'thex',
        'dog' => 'ovqg' => 'dogx',
        'couch' => 'dnl ngm' => 'couchx',
        'stupid' => 'kzt leb' => 'stupid',
        "adove" => 'eovaxm' => "adovex",
        "read reeds" => 'exe oexm xho' => 'readrexeds',
        "dove error meet" =>  "ovadmxemeneixmiv" => 'dovexerxrormexet',
        "read reeds a books" => 'exeoe xmx hopd qeqn qm'
                => 'readrexedsaboxoksx',
        "theweeklychallenge" => "zbxvxmioafdbyaryrodx"
                => 'thewexeklychalxlenge',
        "hide the gold in the tree stump"
                => "bmodz bxdna bekud muix mmo uvif"
                => 'hidethegoldinthetrexestump',
    ;
    ############################################################# Tests
    plan 4;

    die 'Testing only ready for a $cycle of 5' if $cycle ≠ 5;
    subtest 'Chars mapped to grid', {
        plan @crypt-key.elems;

        for @crypt-key -> $c {
            my %h = %ch2grid{$c};
            is $c, @grid[ %h<ROW>][%h<COL>], "char $c maps to grid";
        }
    }

    subtest 'Uinto.from-Int 5', {
        plan @uinto-pos.elems + @uninto-neg.elems + @uinto5.elems;

        for @uinto5 -> %p {
            is Uinto.from-Int( %p.key ), %p.value;
        }
        for 0 .. @uinto-pos.end -> $i {
            is Uinto.from-Int( $i ), @uinto-pos[$i];
        }
        for  - @uninto-neg.end .. 0 -> $i {
            is Uinto.from-Int( $i ), @uninto-neg[* + $i -1];
        }
    }

    subtest '_pairup()', {
        plan 2 × @pairup.elems;

        for @pairup ->  %s {
            is _pairup(%s.key), @(%s.value), "%s.key() -> %s.value()";
            is _pairup(%s.value.join), @(%s.value), '2nd _pairup is noop';
        }
    }

    subtest 'encrypt decrypt', {
        plan 2 × @encoder.elems;

        for @encoder -> %p {
            my $clear = %p.key;
            my $cry = %p.value.key;
            my $uncode = %p.value.value;
            $cry ~~ s:g/ \s //;

            is encrypt( $clear ), $cry,    "encrypt $clear -> $cry";
            is decrypt( $cry   ), $uncode, "decrypt $uncode <- $cry";
        }
    }
}

###################################################### Playfair.rakumod

sub decrypt( Str $encoded --> Str ) {
    encrypt( $encoded, :DECRYPT)
}

sub encrypt( Str $clear, Bool :$DECRYPT --> Str) {

    my @in = $DECRYPT ??  $clear.comb( 2) !! _pairup( $clear);  #FD flag p-up
    my $return = '';

=begin discussion
    my sub inc ( $i is copy --> Uinto) { Uinto.from-Int: ++ $i } ;
    my sub dec ( $i is copy --> Uinto) { Uinto.from-Int: -- $i } ;

    my &inc = $DECRYPT ?? &dec !! &inc;
    my &dec = $DECRYPT ?? &int !! &dec;
=end discussion

    my &alt = $DECRYPT
        ?? sub ($i is copy --> Uinto) { Uinto.from-Int: -- $i }
        !! sub ($i is copy --> Uinto) { Uinto.from-Int: ++ $i }
    ;

    for @in -> $dyad {

        my ( $h, $t) = $dyad.comb;

        my $hR = %ch2grid{ $h }<ROW>;
        my $hC = %ch2grid{ $h }<COL>;
        my $tR = %ch2grid{ $t }<ROW>;
        my $tC = %ch2grid{ $t }<COL>;

        if  $hC == $tC  {           # vert
            $return ~= @grid[ &alt($hR) ][$hC] ~ @grid[ &alt($tR) ][$tC];
            next;
        }
        if  $hR == $tR  {           # hori
            $return ~= @grid[$hR][ &alt($hC) ] ~ @grid[$tR][ &alt($tC) ];
            next;
        }
                                    # rect
        $return ~= @grid[$hR][$tC] ~ @grid[$tR][$hC];
        next;
    }
    $return;
}

# or _pad-and-make-pairs 
sub _pairup( Str $clear, Str $pad = $padding --> Array ) {
    my $in = $clear;
    $in ~~ s:g/ \s //;
    $in ~~ s:g/(.)$0/$0$pad$0/;
    $in = $in.chars %% 2 ?? $in !! $in ~ $pad;
    $in.comb(2).Array;
}
