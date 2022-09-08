use v6;
unit sub MAIN(IO:D(Str:D) $input is copy --> Nil);
$input.slurp.lines.map({
    my (Date(), Numeric()) = $^l.split: ', '
}).sort({
    @^a[0] cmp @^b[0]
}).rotor(2 => -1).grep({
    @^t[0;1] < @^t[1;1]
}).map({
    put @^t[1;0]
})
