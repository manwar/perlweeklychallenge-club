#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my @matrix = @args.map({ [ $_.words.map({ .Int }) ] });
    say q{(},
        %(@matrix.map({ @$_.grep({ $_ == 1}).elems }).kv)
        .sort({ $^a.value <=> $^b.value || $^a.key <=> $^b.key })
        .map({ $_.key })
        .join(q{, }),
    q{)};
}