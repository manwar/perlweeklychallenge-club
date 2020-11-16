#!/usr/bin/env perl6
use v6;

my %*SUB-MAIN-OPTS=:named-anywhere,;
sub MAIN(
    Str :b(:$by) ="values",
    *@ARGS,
    ) {

    sub chrt(%h, Str $by) {
	%h.sort({ ($by eq "labels") && $_.key
		  || ($by eq "values") && -$_.value })
	.map({ sprintf("%10s", $_.key) ~ ' | ' ~ '#' x $_.value })
    }

    my %h=@ARGS;
    for chrt(%h.map({$_.key => $_.value.Int}).Hash,$by) {.say};
}

sub USAGE() {
    print Q:c:to/EOH/;
    Usage: <script> [hash passed as key value key value ..] [-b|--by=values(default)|labels]
EOH
}
