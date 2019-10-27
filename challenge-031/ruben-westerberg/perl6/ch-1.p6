#!/usr/bin/env perl6

my $numerator=@*ARGS[0]//1;
my $denominator=@*ARGS[1]//0;
my $result;

try $result=($numerator/$denominator).Str;

put "Division ok: $numerator/$denominator = $result" unless $!;
put "Division failed: Divide by zero" if $!;

