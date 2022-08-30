use v6;

unit sub MAIN(*@args);

m/(.) {} :my $c = $0; <!before .* $c>/.[0].Str.say for @args
