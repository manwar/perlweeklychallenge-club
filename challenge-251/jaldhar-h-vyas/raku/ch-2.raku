#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my @matrix = @args.map({ [ $_.words.map({ .Int }) ] });
    my @mins = @matrix.keys.map({ @matrix[$_].min || -1 });
    my @maxs  = @matrix[0].keys.map({ @matrix[*;$_].max || -1 });

    (@mins ∩ @maxs).keys.join(q{ }).say;
}