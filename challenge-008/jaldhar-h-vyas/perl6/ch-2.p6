#!/usr/bin/perl6

sub center(@args) {
    my $maxLength = @args>>.chars.max;
    return @args.map({ .indent(($maxLength - .chars) / 2) ~ "\n"; });
}

center(@*ARGS).print;
