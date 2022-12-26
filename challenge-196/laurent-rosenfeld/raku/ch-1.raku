sub find_132 (@input, @part-result) {
    # say @input, " - ", @part-result;
    given @part-result.elems {
        when 3 { return @part-result }
        when 2 {
            for 0..@input.end -> $i {
                my $ret = find_132 @input[$i^..@input.end],
                    (@part-result, @input[$i]).flat
                    if @input[$i] > @part-result[0]
                    && @input[$i] < @part-result[1];
                return $ret if $ret;
            }
        }
        when 1 {
            for 0..@input.end -> $i {
                my $ret =find_132 @input[$i^..@input.end],
                    (@part-result, @input[$i]).flat
                    if @input[$i] > @part-result[0];
                return $ret if $ret;
            }
        }
        when 0 {
            for 0..@input.end -> $i {
                my $ret = find_132(@input[$i^..@input.end],
                    (@input[$i],));
                return $ret if $ret;
            }
        }
    }
}
for <3 1 4 2>, <1 2 3 4>, <1 3 2 4 6 5>, <1 3 4 2> -> @test {
    say @test, "\t=> ", (find_132 @test, ()) // "()";
}
