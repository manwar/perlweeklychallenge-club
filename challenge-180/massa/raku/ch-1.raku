use v6;

unit sub MAIN(*@args);
m/(.) {} :my $c = $0; <!before .* $c>/.[0].pos.map(*-1).head.say for @args
