#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my ($array1, $array2, $array3) = @args.map({ ($_.split(q{ })) });

    say q{(}, ([∪] (@$array1 ∩ @$array2, @$array2 ∩ @$array3, @$array1 ∩ @$array3)).keys.sort.join(q{, }), q{)};
}