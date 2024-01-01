#!/usr/bin/env -S perl -wl

my $smallest_index = sub {
    my $retval=
    (sort {$a<=>$b}
    (grep {($_ % 10) == ($_[$_])} (0 .. $#_))
    )[0];
    defined($retval) ? $retval : -1;
};

print &$smallest_index(0,1,2); #0
print &$smallest_index(4,3,2,1); #2
print &$smallest_index(1,2,3,4,5,6,7,8,9,0); #-1
