sub task2_substr ( Str $word is copy --> Str ) {
    my @fs = $word.match(:g, /:i <[aeiou]>/)
                  .map({ .from, .Str });

    for @fs Z @fs.reverse -> ( ($i, $ic), ($j, $jc) ) {
        $word.substr-rw($i,1) = $jc.lc;
    }

    return $word.tclc;
}
sub task2_array ( Str $word --> Str ) {
    my @a = $word.comb;

    @a[ @a.grep(:k, /:i <[aeiou]>/) ] .= reverse;

    return @a.join.tclc;
}
sub task2_split ( Str $word --> Str ) {
    # .split() with `:v` captures the seperator in the even positions.
    my @parts = $word.split(:v, /:i <[aeiou]>/);

    my @k = @parts.keys.grep(* !%% 2);

    @parts[@k] .= reverse;

    return @parts.join.tclc;
}

my @tests =
    <Raku  Ruka>,
    <Perl  Perl>,
    <Julia Jaliu>,
    <Uiua  Auiu>,

    <Bcdf  Bcdf>,
    <Alphabet  Elphabat>,
    <Zoologicoarchaeologist Ziologecaarchoiologost>;
;
my @subs = 
    :&task2_substr,
    :&task2_array,
    :&task2_split,
;
use Test; plan +@tests * +@subs;
for @subs -> ( :key($sub_name), :value(&task2) ) {
    for @tests -> ( Str $in, Str $expected ) {
        is task2($in), $expected, "$sub_name $in -> $expected";
    }
}
