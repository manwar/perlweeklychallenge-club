#!/usr/bin/env raku
use Test;

is missing-letter(<a c ? g i>), 'e';
is missing-letter(<a d ? j m>), 'g';
is missing-letter(<a e ? m q>), 'i';
is missing-letter(<a c f ? k>), 'h';
is missing-letter(<b e g ? l>), 'j';

# E Choroba tests
is missing-letter(<? c e g i>), 'a', 'Beginning constant';
is missing-letter(<a ? e g i>), 'c', 'Second constant';
is missing-letter(<a c e ? i>), 'g', 'Fourth constant';
is missing-letter(<a c e g ?>), 'i', 'End constant';
is missing-letter(<? c f h k>), 'a', 'Beginning alternating';
is missing-letter(<a ? f h k>), 'c', 'Second alternating';
is missing-letter(<a c ? h k>), 'f', 'Fourth alternating';
is missing-letter(<a c f h ?>), 'k', 'End alternating';

sub missing-letter($seq)
{
    given $seq.first('?', :k)
    {
        when 0 { chr(.[1].ord - (.[3].ord - .[2].ord)) given $seq }
        when 1 { chr(.[0].ord + (.[3].ord - .[2].ord)) given $seq }
        when 2 { chr(.[3].ord - (.[1].ord - .[0].ord)) given $seq }
        when 3 { chr(.[2].ord + (.[1].ord - .[0].ord)) given $seq }
        when 4 { chr(.[3].ord + (.[2].ord - .[1].ord)) given $seq }
    }
}
