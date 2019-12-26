use strict;
use warnings;
use feature qw/say/;

my @a = ( [ qw /I L O V E Y O U / ],
          [ qw /244 42 0 1233 222 0 / ],
          [ qw /! ???? £ $ %% ^ / ],
          [ qw /a b c d e f g h i j k/ ]
        );
my $max_size = 0;
for (@a) {
    $max_size = scalar @$_ if @$_ > $max_size;
}
my @b;
for my $i (0..$max_size - 1) {
    push @b, [ map { $a[$_][$i]} 0 .. @a - 1];
}
say join "\t", map {$_ // "" } @$_ for @b;
