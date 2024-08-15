use strict; use warnings; use Test::More tests=>3;

sub good_int {
    (
        grep length==3,
        split / /,
        shift =~ s/(.)\1*/$& /gr
    )[0]
    //
    -1
}

is good_int(12344456) => "444";
is good_int(1233334)  => -1;
is good_int(10020003) => "000";
