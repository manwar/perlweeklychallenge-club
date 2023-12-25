#!/usr/bin/env raku
use Test;

is-deeply DI("IDID"),                 (0,4,1,3,2);
is-deeply DI("III"),                  (0,1,2,3);
is-deeply DI("DDI"),                  (3,2,0,1);
is-deeply DI("DDID"),                 (4,3,0,2,1);
is-deeply DI("IDDID"),                (0,5,4,1,3,2);
is-deeply DI("DDD"),                  (3,2,1,0);
is-deeply DI("IDDIIDIIIDIIDDIDIDDI"), (0,20,19,1,2,18,3,4,5,17,6,7,16,15,8,14,9,13,12,10,11);

sub DI($str)
{
    my @a  = flat $str.comb, "I";
    my %h := { :I(0), :D(@a.end) }

    gather while @a.shift -> $a
    {
        take %h{$a}.abs;
        %h{$a}--
    }
}
