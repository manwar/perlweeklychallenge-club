#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    @ints.classify({ $_ }, :into(my %elements;) );
    if all %elements.values.map({ @$_.elems % 2 == 0 }) {
        %elements.values
            .map({| @$_.batch(2) })
            .map({ q{(} ~ @$_.join(q{, }) ~ q{)} })
            .join(q{, })
            .say;
    } else {
        say '()';
    }
}
