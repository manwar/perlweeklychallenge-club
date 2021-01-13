#!/usr/bin/env perl6
#
#
#       .raku
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


unit sub MAIN (*@array) ;

@array.elems == 0 and @array = 1,2,15,2;
@array.elems == 1 and do { say 1; exit };

my $idx = 0;
while my $jump = @array[$idx] {
    $idx += $jump;
    $idx == @array.end and do { say 1; exit };
}
say 0;








