#!/usr/bin/env raku

multi sub MAIN('test') {
    use Test;
    is split-up( words => ("one.two.three","four.five","six"),
                 separator => "." ), ("one","two","three","four","five","six");
    is split-up( words =>('$perl$$', '$$raku$'),
                 separator => '$' ), ('perl','raku');
    done-testing;
}

multi sub MAIN($separator, *@words) {
    split-up(:@words, :$separator).join(',').say;
}

sub split-up( :@words, :$separator ) {
    @words.map( { | $_.split($separator) } ).grep( * ne '' ).list;
}
