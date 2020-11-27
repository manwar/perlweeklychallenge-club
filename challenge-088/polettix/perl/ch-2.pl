#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

$|++;

sub get_row ($M, $r, $c, $n) { $M->[$r]->@[$c .. $c + $n - 1] }
sub get_col ($M, $r, $c, $n) { map { $M->[$r + $_][$c] } 0 .. $n - 1 }
sub get_frame ($M, $r, $c, $nr, $nc) {
   ($nr, $nc) = ($nr - 1, $nc - 1); # more useful like this
   return (
      get_row(        $M, $r      , $c      , $nc),
      get_col(        $M, $r      , $c + $nc, $nr),
      reverse(get_row($M, $r + $nr, $c +   1, $nc)),
      reverse(get_col($M, $r +   1, $c      , $nr)),
   );
}

sub spiral_matrix ($M) {
   my ($rows, $cols) = (scalar($M->@*), scalar($M->[0]->@*));
   my ($sr, $sc) = (0, 0);
   my @v;
   while ($rows > 0 && $cols > 0) {
      if ($rows == 1)    { push @v, get_row($M, $sr, $sc, $cols) }
      elsif ($cols == 1) { push @v, get_col($M, $sr, $sc, $rows) }
      else {               push @v, get_frame($M, $sr, $sc, $rows, $cols) }
      ($sr, $sc, $rows, $cols) = ($sr + 1, $sc + 1, $rows - 2, $cols - 2);
   }
   return @v;
}

sub read_matrix ($fh) {
   local $/ = ''; # read by "paragraph"
   my $text = <$fh> or return;
   return [ map { [grep /\d/, split m{\D+}mxs] } split m{\n+}mxs, $text ];
}

sub print_matrix ($fh, $M) {
   say {$fh} '[ ', join(', ', map {sprintf '%3d', $_} $_->@*), ' ]'
      for $M->@*;
   return;
}

while (my $M = read_matrix(\*DATA)) {
   print_matrix(\*STDERR, $M);
   say '[ ', join(', ', spiral_matrix($M)), ' ]';
}

__END__
[  1,  2,  3,  4 ]
[  5,  6,  7,  8 ]
[  9, 10, 11, 12 ]
[ 13, 14, 15, 16 ]

[ 1, 2, 3 ]
[ 4, 5, 6 ]
[ 7, 8, 9 ]

[ 1, 2, 3 ]
[ 4, 5, 6 ]

[  1,  2,  3,  4 ]
[  5,  6,  7,  8 ]
[  9, 10, 11, 12 ]
