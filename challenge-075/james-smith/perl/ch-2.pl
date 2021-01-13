use strict;
use warnings;
use feature qw(say);

say q();
say lrh(qw(2 1 4 5 3 7));
say q();
say lrh(qw(3 2 3 5 7 5));
say q();

## Could import max/min - but these are easy to write ourselves in this case....

sub lrh {
  my @V = @_;
  my ($mx,$y) = 0;
  $mx = $mx < $_ ? $_ : $mx foreach @V;
## The following chunk renders the histogram as requested...
## Render output as table....
  say sprintf( ' %2d', $y=$_ ), map { $_ < $y ? q(   ) : q(  #) } @V foreach reverse 1..$mx;
  say q( --),                   map { q( --)                    } @V;
  say q(   ),                   map { sprintf ' %2d', $_        } @V;
  say q();

## Now do the calculation of mx area
  my $mx_area = 0;
  foreach my $s ( 0 .. @V-1 ) { ## Loop through each start of block...
    my $mn = $mx;
    foreach ( $s .. @V-1 ) {
      $mn      = $V[$_]          if $mn      > $V[$_];          ## Loop through ends, keeping track of minimum value
      $mx_area = $mn * ($_-$s+1) if $mx_area < $mn * ($_-$s+1); ## And check to see if the area is greater than any other area!
    }
  }
  return $mx_area;
}
