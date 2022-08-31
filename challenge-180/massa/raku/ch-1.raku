use v6;

unit sub MAIN(*@args);
m/:my %visited; . :my $c = $¢; <!{ %visited{$c}++ }> <!before .* $c>/.&{ .pos // 0 - 1 }.say for @args
