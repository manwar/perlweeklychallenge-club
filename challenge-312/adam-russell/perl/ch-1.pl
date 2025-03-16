
  
use v5.40;

  
sub minimum_time{
    my($s) = @_;
    my @c = split //, lc($s);
    my $time = 0;
    my $moves;
    my $current = q/a/;
    {
        my $next = shift @c;
        my($x, $y) = (ord($current) - 96, ord($next) - 96);
        $moves =  ($x + 26) - $y if $y >= ($x + 13);
        $moves = $y - $x if $y <= ($x + 13) && $y >= $x;
        $moves =  ($y + 26) - $x if $x >= ($y + 13);
        $moves = $x - $y if $x <= ($y + 13) && $x >= $y;
        $time += $moves;
        $time++;
        $current = $next; 
        redo if @c > 0;
    }
    return $time;
}

  
MAIN:{
  say minimum_time q/abc/;
  say minimum_time q/bza/;
  say minimum_time q/zjpc/;
}

