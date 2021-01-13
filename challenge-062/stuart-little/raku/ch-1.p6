#!/usr/bin/env perl6
use v6;

my %*SUB-MAIN-OPTS=:named-anywhere,;
sub MAIN(
    Bool :u(:$unique),
    *@FILE,
) {    
    my @emails=((@FILE)
    ?? @FILE[0].IO.lines
    !! $=finish.chomp.split(/\s+/)).sort({ $_.split('@').[1].lc, $_.split('@').[0] }); 

    for (($unique)
	 ?? (@emails.unique(as => &{ $_.split('@').[0], $_.split('@').[1].lc }, with => &[eqv]))
	 !! (@emails)) {.say}    
}

=finish
name@example.org
rjt@cpan.org
Name@example.org
rjt@CPAN.org
user@alpha.example.org
