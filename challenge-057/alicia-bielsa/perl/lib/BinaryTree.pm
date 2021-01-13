package BinaryTree;
use Moose;
use BinaryTreeNode;
use Data::Dumper;

has 'height' => (is => 'rw', isa => 'Int');
has 'root' =>   (is => 'rw', isa => 'BinaryTreeNode');
 

sub addValues {
    my $self = shift;
    my @aValues = @_;
    $self->{root} = BinaryTreeNode->new( level => 1 );
    $self->_addValues( $self->{root}, @aValues );
}



sub _addValues {
    my $self = shift;
    my $node = shift;
    my @aValues = @_;
    
    my @aCurrentNodes = ($node);
    while(scalar(@aCurrentNodes)){
        my @aNextNodes =();
         foreach my $node (@aCurrentNodes){
            $node->{value} = shift(@aValues);
            unless ($node->{level} == $self->{height}){
                $node->{left} = BinaryTreeNode->new(root => 0, level => $node->{level} +1 );
                $node->{right} = BinaryTreeNode->new(root => 0, level => $node->{level} +1 );
                push (@aNextNodes, $node->{left});
                push (@aNextNodes, $node->{right});
            }
        }
        @aCurrentNodes = @aNextNodes;
    }  
}


sub mirrorTree {
    my $self = shift;
    my @aCurrentNodes = ($self->{root}->{left},$self->{root}->{right});
    while(scalar(@aCurrentNodes)){
        my @aNextNodes =();
        my @aValues =();
        foreach my $node (@aCurrentNodes){
            push(@aValues, $node->{value});
        }
        foreach my $node (@aCurrentNodes){
            $node->{value} =  pop @aValues;
            unless ($node->{level} == $self->{height}){
                push (@aNextNodes, $node->{left});
                push (@aNextNodes, $node->{right});
            }
        }
        @aCurrentNodes = @aNextNodes;
    }
}


sub drawBinaryTree {
    my $self = shift;
    my $textToPrint ='';
    my @aCurrentNodes = ($self->{root});
    while(scalar(@aCurrentNodes)){
        my @aNextNodes =();
        my $treeDown = "";
        foreach my $node (@aCurrentNodes){
           my $spaces = ($self->{height} * $self->{height} )/ scalar(@aCurrentNodes) ;
            $textToPrint .= " " x $spaces  ;
            $textToPrint .= $node->{value};
            $textToPrint .= " " x  $spaces  ;
            $treeDown .= " " x  ( $spaces - 1) ;
            $treeDown .= "/ \\"  ;
            $treeDown .= " " x  $spaces ;
            unless ($node->{level} == $self->{height}){
                push (@aNextNodes, $node->{left});
                push (@aNextNodes, $node->{right});
            }
        }
        $textToPrint .= "\n";
        if (@aNextNodes){
            $textToPrint .= $treeDown;
            $textToPrint .=  "\n";
        }
        @aCurrentNodes = @aNextNodes;
    }
    print $textToPrint;
}



1;