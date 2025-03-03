#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    @ints.keys.classify({ $_ %% 2 ?? 'evens' !! 'odds' }, as => { @ints[$_] }, into => my %oe);

    my @evens = %oe<evens>.sort({$^a <=> $^b});
    my @odds =  %oe<odds>.sort({$^b <=> $^a});

    my @result;
    while @evens || @odds {
        if @evens {
            @result.push(@evens.shift);
        }
        if @odds {
            @result.push(@odds.shift);
        }
    }

    say q{(}, @result.join(q{, }), q{)};
}
