use v6;

my $num = @*ARGS[0] // 743;
my @multiples = map { $num * $_ }, 1..*;
say @multiples.first: /^<[01]>+$/; # default 743: -> 10110001
