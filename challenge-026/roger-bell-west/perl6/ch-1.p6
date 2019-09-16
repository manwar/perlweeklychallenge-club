#! /usr/bin/perl6

my $a=shift @*ARGS or die "need two parameters\n";
$a ~~ s:g/<-[A..Za..z]>//;
my %s=map {$_ => 1}, split '',$a;

my $b=shift @*ARGS or die "need two parameters\n";
$b ~~ s:g/<-[A..Za..z]>//;
my $t=0;
map {if ($_ and %s{$_}:exists) {$t++}}, split '',$b;

say $t;
