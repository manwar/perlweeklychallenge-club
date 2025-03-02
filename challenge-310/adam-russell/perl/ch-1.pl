
  
use v5.38;

  
sub array_intersections{
    my @common_elements;
    my $x = shift @_;
    my $y = shift @_;
    if($x && $y){
        my @common = map {
            my $x = $_;
            grep {$x == $_} @{$y}
        } @{$x};
        push @common_elements, @common;
    }
    {
        $x = shift @_;
        my @common = map {
            my $x = $_;
            grep {$x == $_} @{$y}
        } @common_elements;
        @common_elements = @common;
        redo if @_ > 1;
    }
    return (join q/, /, @common_elements) || q#n/a#;
}

  
MAIN:{
  say array_intersections [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3];
  say array_intersections [1, 0, 2, 3], [2, 4, 5];
  say array_intersections [1, 2, 3], [4, 5], [6];
}

