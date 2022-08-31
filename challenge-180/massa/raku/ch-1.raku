use v6;

unit sub MAIN(*@args);
my sub minus-one($_) { $_ // 0 - 1 }
my %visited;
m/(.) {} :my $c = $0; <!{ %visited{$c}++ }> <!before .* $c>/.pos.&minus-one.say for @args
