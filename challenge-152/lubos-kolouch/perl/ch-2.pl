use strict;
use warnings;
use Moose;

package Point;
use Moose;

has 'x' => ( is => 'rw', isa => 'Int' );
has 'y' => ( is => 'rw', isa => 'Int' );

package Rectangle;
use Moose;
use List::Util qw/min max/;

has 'left'  => ( is => 'rw', isa => 'Point' );
has 'right' => ( is => 'rw', isa => 'Point' );

sub get_area {
    my $self = shift;
    return abs( $self->left->x - $self->right->x ) * abs( $self->left->y - $self->right->y );
}

sub get_total_area {

    my ( $first, $second ) = @_;

    my $area1 = $first->get_area;
    my $area2 = $second->get_area;

    # calculate the overlapping area
    my $x_dist = min( $first->right->x, $second->right->x ) - max( $first->left->x, $second->left->x );
    my $y_dist = min( $first->right->y, $second->right->y ) - max( $first->left->y, $second->left->y );
    my $area_i = 0;
    $area_i = $x_dist * $y_dist if ( $x_dist > 0 ) and ( $y_dist > 0 );

    return $area1 + $area2 - $area_i;
}

use Test::More;

my $first  = Rectangle->new( left => Point->new( x => -1, y => 0 ),  right => Point->new( x => 2, y => 2 ) );
my $second = Rectangle->new( left => Point->new( x => 0,  y => -1 ), right => Point->new( x => 4, y => 4 ) );

is( get_total_area( $first, $second ), 22 );

$first  = Rectangle->new( left => Point->new( x => -3, y => -1 ), right => Point->new( x => 1, y => 3 ) );
$second = Rectangle->new( left => Point->new( x => -1, y => -3 ), right => Point->new( x => 2, y => 2 ) );

is( get_total_area( $first, $second ), 25 );

done_testing;
