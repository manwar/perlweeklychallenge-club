use v6;

my regex first-unique { :my %visited; . :my $c = $¢; <!{ %visited{$c}++ }> <!before .* $c> }

@*ARGS.map({ $^s ~~ &first-unique ?? $/.pos - 1 !! -1 })».say
