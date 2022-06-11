use Modern::Perl;
use experimental qw<signatures>;

sub task1 ( $x, $y, $pos ) {
    return substr $x, $pos-1, 1 if length($x) < $pos;
    ($x, $y) = ($y, "$x$y")  while length($y) < $pos;
    return substr $y, $pos-1, 1;
}

@ARGV = qw<1234 5678> if not @ARGV;
die if @ARGV != 2;
say task1( @ARGV, 51 );
