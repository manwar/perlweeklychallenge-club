#!/usr/bin/env raku

=begin pod

Week 173:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-173

Task #2: Sylvester’s sequence

    Write a script to generate first 10 members of Sylvester's sequence.

=end pod

use Test;

is sylvester-sequence(10),
   [
     2
    ,3
    ,7
    ,43
    ,1807
    ,3263443
    ,10650056950807
    ,113423713055421844361000443
    ,12864938683278671740537145998360961546653259485195807
    ,165506647324519964198468195444439180017513152706377497841851388766535868639572406808911988131737645185443
   ],
   'Example';

done-testing;

#
#
# METHOD

sub sylvester-sequence(Int $n where $n >= 3) {

    my @ss = (2);
    for 1 .. $n-1 {
        @ss.push: 1 + (@ss[@ss.end] * (@ss[@ss.end] - 1));
    }
    return [ @ss ];
}
