# ䷅ U+4DC5 https://unicode-table.com/en/4DC5/ Hexagram for "Conflict"
# ䷿ U+4DFF https://unicode-table.com/en/4DFF/ Hexagram for "Before Completion"

multi sub infix:<䷅> ( Range $a, Range $b --> Bool ) {
    ?(    $a.min|$a.max ~~ $b
       or $b.min|$b.max ~~ $a )
}
multi sub prefix:<䷿> ( &op, @a --> Seq ) {
    return @a.kv.map: -> Int $k, $v {
        $v if op( $v, @a.head($k).any );
    }
}
my &prefix:<䷅䷿> = &prefix:<䷿>.assuming(&infix:<䷅>);

my @tests =
    ( (1,4), (3,5), (6,8), (12, 13), ( 3,20) ),
    ( (3,4), (5,7), (6,9), (10, 12), (13,15) ),
    ( (3,4), (5,7), (8,8), (10, 12), (13,15) ),
;

$_ .= map({ Range.new(|$_) }) for @tests;

say ䷅䷿ $_ for @tests;

# Working, but not used:
# Single pass, so linear in the length of the input array, 
# *but* horrific performance if any interval is very wide.
# sub conflicts_with_any_earlier ( @intervals ) {
#     my Set $acc;
#     return gather for @intervals {
#         my Set $i = set .[0] .. .[1];
#         .take if $i ∩ $acc;
#         $acc ∪= $i;
#     }
# }
# say .&conflicts_with_any_earlier for @tests;
