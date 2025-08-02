
  
use v5.40;

  use Ch2;
  
sub parse_boxes{
    my($record) = @_; 
    my $parser = Ch2->new();
    my $boxes = $parser->parse($record); 
    my $full = 0;
    for my $box (keys %{$boxes}){
        $full++ if 1 <= (grep { $_ eq q/R/ } @{$boxes->{$box}}) &&
                   1 <= (grep { $_ eq q/G/ } @{$boxes->{$box}}) &&
                   1 <= (grep { $_ eq q/B/ } @{$boxes->{$box}}); 
    }   
    return $full;
}

  
MAIN:{
  say parse_boxes $ARGV[0];
}  

