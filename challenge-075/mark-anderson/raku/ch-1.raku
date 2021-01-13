=begin usage 

usage: raku ch-1.raku 6 1 2 4

output: 111111
        11112
        1122
        114
        222
        24

        6 combinations

=end usage

# This program just creates the nested loops needed to create the 
# combinations and then executes that code.

use MONKEY-SEE-NO-EVAL;

unit sub MAIN(Int $S, *@C where @C.all ~~ Int);

my $eval = "my \@results;\n";

for ^@C -> $i {
my $sum-str = (map { "\$v$_" }, 0..$i).join(" + ");
my $out-str = (map { "\@C[$_] x \$v$_ div \@C[$_]" }, 0..$i).join(",\n");

$eval ~= q :to/END/;        
loop (my $v\qq[$i] = 0; $v\qq[$i] <= $S; $v\qq[$i] += @C[\qq[$i]]) {
@results.unshift: [\qq[$out-str]] if \qq[$sum-str] == $S;
next if \qq[$sum-str] >= $S;

END
}

$eval ~= "}" x @C;
$eval ~= "\nsay .join for \@results;";
$eval ~= "\nsay \"\\n\", @results.elems, \" combinations\";"; 

EVAL $eval;
