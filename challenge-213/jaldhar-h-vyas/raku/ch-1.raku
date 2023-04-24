#!/usr/bin/raku

sub MAIN(
    *@list
) {

    @list.classify( { $_ %% 2 ?? 'even' !! 'odd' }, :into( my %class; ) );

    my @results = %class{'even'}.sort({ $^a <=> $^b });
    @results.push(| %class{'odd'}.sort({ $^a <=> $^b }) );

    say q{(}, @results.join(q{,}), q{)};
}