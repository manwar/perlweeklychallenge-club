use strict;
use warnings;

package Node {
    use Moose;
    has 'value' => ( is => 'ro' );
    has 'left'  => ( is => 'rw' );
    has 'right' => ( is => 'rw' );
}

package BinaryTree {
    use Moose;
    has 'root' => ( is => 'rw' );

    sub diameter {
        my ($self) = @_;
        my $max = 0;
        _depth( $self->root, \$max );
        return $max;
    }

    sub _depth {
        my ( $node, $max ) = @_;
        return 0 unless $node;

        my $left  = _depth( $node->left,  $max );
        my $right = _depth( $node->right, $max );
        $$max = $left + $right if $left + $right > $$max;

        return [ $left, $right ]->[ $left < $right ] + 1;
    }
}

# Test
my $tree = BinaryTree->new(
    root => Node->new(
        value => 1,
        left  => Node->new(
            value => 2,
            left  => Node->new( value => 3 ),
            right => Node->new( value => 4 )
        ),
        right => Node->new(
            value => 5,
            left  => Node->new( value => 6 ),
            right => Node->new(
                value => 7,
                left  => Node->new(
                    value => 8,
                    left  => Node->new( value => 9 )
                ),
                right => Node->new( value => 10 )
            )
        )
    )
);

print $tree->diameter();    # prints: 6
