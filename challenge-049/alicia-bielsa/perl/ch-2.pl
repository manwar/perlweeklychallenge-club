use strict;
use warnings;

my %hCache =();
my ($head, $tail);
my $capacity = 3;
my ($result, $orderCache );


set(1, 3);
print "Set 1 => 3\n";
verifyOrderCache('1');


set(2, 5);
print "Set 2 => 5\n";
verifyOrderCache('21');

set(3, 7);
print "Set 3 => 7\n";
verifyOrderCache('321');


$result = get(2) ;     # returns 5
if ( $result == 5){
    print "Return OK $result\n";
}
verifyOrderCache('231');


$result = get(1) ;      # returns 3
if ( $result == 3){
    print "Return OK $result\n";
}
verifyOrderCache('123');


$result= get(4);    # returns -1
if ( $result == -1){
    print "Return OK $result\n";
}
verifyOrderCache('123');


set(4, 9);
print "Set 4 => 9\n";
verifyOrderCache('412');

$result = get(3) ;   
if ( $result == -1){
    print "Return OK $result\n";
}
verifyOrderCache('412');



sub set {
    my $id = shift;
    my $value = shift;
    if (exists $hCache{$id}){
        $hCache{$id}->{value} = $value;    
        moveToHead($hCache{$id});          
    } else {      
        my $newNode = createNode($id, $value);
        $hCache{$id} = $newNode;      
        addToHead($newNode);
        resetTail($newNode); 
    }  
   
}

sub get  {
    my $id = shift;
    if (exists $hCache{$id}){       
        moveToHead($hCache{$id});       
        return $hCache{$id}->{value};
    } else {
        return -1;
    }
}

sub createNode {
    my $id = shift;
    my $value = shift;
    my %hNode = ();
    
    $hNode{next} = 0;
    $hNode{prev}  = 0;
    $hNode{value}  = $value;
    $hNode{id}  = $id;
    return \%hNode;
    
}

sub addToHead {
    my $node = shift;
    
    
    unless (defined $head ){
      $head = $node;
      return ;
    }
    
    
    $head->{prev} = $node;  
    $node->{prev} = 0;
    $node->{next} = $head;
    $head = $node;
    
}

sub moveToHead {
    my $node = shift;     
      
    if ($node eq $head ){
        return;
    }
    if ($node eq $tail ){
        resetTail($node);
    } else {
        extractNode($node);
    }
     addToHead($node);    
      
}

sub resetTail {
    my $node = shift;
    
    unless (defined $tail ){
      $tail = $node;
      return ;
    }
    
    if ($node eq $tail ){
        $tail = $tail->{prev};
        $tail->{next} = 0;
    }
    
    if (scalar keys %hCache > $capacity){
        removeTail();
    } 
}       

sub removeTail {
    delete $hCache{$tail->{id}};
    $tail->{prev}->{next} = 0;
    $tail = $tail->{prev};
}

sub extractNode {
    my $node = shift;   
    
    $node->{prev}->{next} = $node->{next};
    $node->{next}->{prev} = $node->{prev};

}

sub getOrderCache {
    my $node = $head;
    my $nextNode = 1;
    my $orderCache= '';

    while ( $nextNode ){        
        if ($node->{next} == 0){
            $nextNode = 0;
        }
        $orderCache .= $node->{id};
        $node = $node->{next};
       
    }
    return $orderCache;
}

sub verifyOrderCache {
    my $expectedOrder = shift;
    $orderCache = getOrderCache();
    if ( $orderCache eq $expectedOrder ){
        print  "Order cache OK $orderCache\n";
    } 
}

