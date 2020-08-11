#!/usr/bin/env perl
use feature qw<say>;
my $numerator=$ARGV[0]//1;
my $denominator=$ARGV[1]//0;
my $result=eval {$numerator/$denominator};
say "Division ok: $numerator/$denominator = $result" if defined $result;
say "Division failed: divide by zero" if !defined $result;
		
