#!/usr/bin/env perl6
#
#
#       time-travel.raku
#
#       one-liner:
#     
#         raku -e '$_=@*ARGS[0];m/^(\d+)(":"\d+)\s?(am|pm)*$/;my$c=$0>11??"pm"!!"am";my$h=$0%12;if $2 {$2~~"pm"and$h+=12;"%02d%s\n".printf($h,$1)}else{$h||=12;"$h$1$c".say}' 
# 
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;

use Test;

plan 8;

is timef("5:15am"), "05:15", '12->24am';
is timef("5:15pm"), "17:15", '12->24pm';
is timef("12:15am"), "00:15", '12->24am-mid';
is timef("12:15pm"), "12:15", '12->24pm-noon';
is timef("5:15"),  "5:15am", '24->12am';
is timef("17:15"), "5:15pm", '12->24am';
is timef("12:00"), "12:00pm", '24->12-noon';
is timef("00:00"), "12:00am", '24->12-mid';



sub timef ($_) {
    m:i/^ (\d+) (":"\d+) \s? (am|pm)* $/;
    my $c = $0 > 11 ?? 'pm'
                    !! 'am';
    my $h = $0 % 12;
    if ($2) {
        $h += 12 if $2 eq "pm";
        "%02d%s".sprintf($h,$1);
    }
    else{
        $h ||= 12;
        "$h$1$c";
    }
}

