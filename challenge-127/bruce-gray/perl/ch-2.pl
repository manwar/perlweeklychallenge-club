use strict;
use warnings;
use 5.026;
use experimental qw<signatures>;
use List::Util   qw<first>;
use Test::More;

sub happens_earlier ( $comparitor, $list_aref ) {
    my @l = @{$list_aref};
    my @r;
    for my $i ( keys @l ) {
        my $li = $l[$i];
        push @r, $li if defined first { $comparitor->($li, $_) } @l[0 .. $i-1];
    }
    return @r;
}

# sub conflicts_with { $_[0][0] <= $_[1][1] && $_[1][0] <= $_[0][1] } # Equivalent to sub below, but just rude!
sub conflicts_with ( $x, $y ) {
    my ( $x_min, $x_max, $y_min, $y_max ) = ( @{$x}, @{$y} );
    return !(     $x_min > $y_max
               or $y_min > $x_max );
}
sub all_conflicts_earlier { happens_earlier( \&conflicts_with, @_ ) }


sub format_for_challenge {
    return '[ ' . join( ', ', map { '(' . join(',', @{$_}) . ')' } @_ ) . ' ]';
}
my @tests = (
    [ [ [1,4], [3,5], [6,8], [12, 13], [ 3,20] ] => "[ (3,5), (3,20) ]" ],
    [ [ [3,4], [5,7], [6,9], [10, 12], [13,15] ] => "[ (6,9) ]" ],
    [ [ [3,4], [5,7], [8,8], [10, 12], [13,15] ] => "[  ]" ],
);
plan tests => 0+@tests;
for (@tests) {
    my ($input, $expected) = @{$_};
    is format_for_challenge(all_conflicts_earlier($input)), $expected;
}
