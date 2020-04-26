package BinaryTreeNode;
use Moose;
use Data::Dumper;

has 'value' => (is => 'rw', isa => 'Str');
has 'left' => (is => 'rw', isa => 'BinaryTreeNode' );
has 'right' => (is => 'rw', isa => 'BinaryTreeNode' );
has 'level' => (is => 'rw', isa => 'Int');
has 'root' => (is => 'rw', isa => 'Bool', default => 0);



1;