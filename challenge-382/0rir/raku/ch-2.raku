#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
382-2: Replace Question Mark        Submitted by: Simon Green

You are given a string of only 0, 1 and ? characters.
Write a script to make all possible combinations with
the '?' changed to a zero or one.
=end comment

my @Test =
    # in        exp
    "01??0",  ("01000", "01010", "01100", "01110"),
    "101",    ("101"),
    "???",    ("000", "001", "010", "011", "100", "101", "110", "111"),
    "1?10",   ("1010", "1110"),
    "1?1?0",  ("10100", "10110", "11100", "11110"),
;

plan +@Test ; # ÷ 2;

constant $magic= '?';

# This is included only because (*.flat: :hammer) is voodoo I did.
# Though it is not visible in the code, an intention to generalize
# $magic and the target substrings was in mind.  The clunkiness was
# realized early but completed; the motivations were education,
# conceptual closeness to doneness, and having a correct solver to test
# against.

sub task-hammer( Cool:D(Str) $a is copy where * ~~ / ^ [ <[01]> | $magic]+ $ /
 --> List) {
    return ($a,) if $a ~~ / ^ <[01]>+ $/;
    my @ret = [ $a,];
    my @pass;
    while @ret[0].contains( $magic) {
        @pass = @ret.map: {
            my $s = $_;
            $_ ~~ s/$magic/0/;
            $s ~~ s/$magic/1/;
             $_, $s ;
        };
        @pass.=flat( :hammer ).Array;       # :hammer ?!
        @ret = @pass;
    }
    @ret.List;
}

# Some improvement by not using map.
sub task-append( Cool:D(Str) $a is copy where * ~~ / ^ [ <[01]> | $magic]+ $ /
 --> List) {
    return ($a,) if $a ~~ / ^ <[01]>+ $/;
    my @ret = [ $a,];
    my @pass;
    while @ret[0].contains( $magic) {
        for @ret -> $e {
            my ($f, $g) = $e xx 2;
            $f ~~ s/$magic/0/;
            $g ~~ s/$magic/1/;
            @pass.append: $f, $g;  # splicing @ret is messy w/ ?able speed 
        }
        @ret = @pass;
        @pass = [];
    }
    @ret.List;
}


sub task( Cool:D(Str) $a where * ~~ / ^ [ <[01]> | $magic]+ $ /
 --> List) {
     my @ret;
     my @loca       = $a.indices: $magic;
     my $subst-ct   = -1 + 2**@loca ;       # elems in @ret as returned

     # Make binary strs w. update values: '?1?' --> <00 01 10 11>».Str
     my @update = do for 0..$subst-ct {
        sprintf "%0*b", +@loca, $_;
    }
                                # apply and return one update string
                                sub apply( $upd) {
                                    my @a = $a.comb.Array;
                                    @a[@loca] = $upd.comb;
                                    return @a.join;
                                }
    for @update -> $bstr {
        @ret.push: apply $bstr;
    }
    return @ret.List;
}

for @Test -> $in, $exp {
    is task-hammer( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
    is task-append( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
    is        task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $str = '????';
say qq{\nInput: \$str = "$str"\nOutput: ("&task($str).join( '", "')")};
