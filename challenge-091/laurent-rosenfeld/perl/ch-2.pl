use strict;
use warnings;
use feature "say";

my @tests = ([ qw<1 2 1 2 > ], [ qw< 2 1 1 0 2 > ], [ qw<1 2 1 2 1 > ]);
say "@{$_}  -> ", jump($_) for @tests;

sub jump {
    my @in = @{$_[0]};
    my $i = 0;
    while (1) {
        return 0 unless $in[$i];
        my $next_i = $i + $in[$i];
        return 1 if $next_i == $#in;
        return 0 if $next_i > $#in;
        $i = $next_i;
    }
}
