#!/bin/env raku

unit sub MAIN(Str:D $arr_str);

use MONKEY-SEE-NO-EVAL;

my @a = EVAL $arr_str;
put 'Team ', do with (^+@a).map({ @a[$_].sum }).max(:k) -> @m {
	+@m == 1 ?? @m[0] !! do with (^+@m).map({ @a[$_][@m].sum }).max(:k) -> @n {
		+@n == 1 ?? @m[@n[0]] !! "{@n.join(',')} tie"
	}
};
