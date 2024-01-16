use v5.38;
use Data::Dump q/pp/;
sub lucky_number{
    my $matrix = shift;
    do{
        my $row = $_; 
	my $x = (sort {$a <=> $b} @$row)[0]; 
        my $c = (grep {$row->[$_] == $x} 0 .. @$row - 1)[0]; 
        my @c = map {$_->[$c]} @$matrix;
        return $x if $x == (sort {$b <=> $a} @c)[0]; 
    } for @$matrix;
    return -1; 
}

MAIN:{
    say lucky_number [[3,  7,  8], [9, 11, 13], [15, 16, 17]];   
    say lucky_number [[1, 10,  4,  2], [9,  3,  8,  7], [15, 16, 17, 12]];   
    say lucky_number [[7,  8], [1, 2]];   
}
