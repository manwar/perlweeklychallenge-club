#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub hash_counting_string {
    my ($length) = @_;
    my $s = '#' x $length;
    while (-1 != (my $pos = rindex $s, '##')) {
        my $n = $pos + 2;
        substr $s, $pos + 1 - length $n, length $n, $n;
    }
    return $s
}

use Test::More;

is hash_counting_string(1), '#', '(a)';
is hash_counting_string(2), '2#', '(b)';
is hash_counting_string(3), '#3#', '(c)';
is hash_counting_string(10), '#3#5#7#10#', '(d)';
is hash_counting_string(14), '2#4#6#8#11#14#', '(e)';

is hash_counting_string(200), '#3#5#7#9#12#15#18#21#24#27#30#33#36#39#42#45#'
                            . '48#51#54#57#60#63#66#69#72#75#78#81#84#87#90#'
                            . '93#96#100#104#108#112#116#120#124#128#132#136#'
                            . '140#144#148#152#156#160#164#168#172#176#180#'
                            . '184#188#192#196#200#', 'long string';

is hash_counting_string(201), '#3#5#7#10#13#16#19#22#25#28#31#34#37#40#43#'
                            . '46#49#52#55#58#61#64#67#70#73#76#79#82#85#88#'
                            . '91#94#97#101#105#109#113#117#121#125#129#133'
                            . '#137#141#145#149#153#157#161#165#169#173#177'
                            . '#181#185#189#193#197#201#', 'even longer';

done_testing();
