#!/bin/env raku

sub largest-even(UInt:D $n --> UInt:D) {
    my @d = $n.comb».UInt;                  # get all digits
    my $last-digit = @d.grep(* %% 2).min;   # find the smallest even digit

    my Bool $done = False;
    @d .= grep({ $done or $_ != $last-digit ?? True !! do { $done = True; False }});    # filter out the found even digit, only once

    (@d.sort({ $^b <=> $^a }).join ~ $last-digit).UInt      # 'print' the array, largest to smallest, at last, 'print' the found even digit
}

multi MAIN('test') {
    use Test;

    is largest-even(1026), 6210, '1,0,2,6 -> 6210';
    is largest-even(1428), 8412, '1,4,2,8 -> 8412';
    is largest-even(4176), 7614, '4,1,7,6 -> 7614';

    done-testing;
}

multi MAIN(UInt:D $n) { put largest-even($n) }
