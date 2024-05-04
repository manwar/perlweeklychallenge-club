use v5.38;

use constant WIDTH => 100;

sub line_counts{
    my $s = shift;
    my($width, $line_count) = (0, 1);  
    do{
        $width = $width + $_[ord($_) - ord(q/a/)];
        if($width > WIDTH){
            $width = $_[ord($_) - ord(q/a/)];
            $line_count++;
        }  
    } for split q//, $s;
    return $line_count, $width; 
}

my($s, @w);
$s = q/abcdefghijklmnopqrstuvwxyz/; 
@w = (10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);  
say join q/ /, line_counts $s, @w;

$s = q/bbbcccdddaaa/; 
@w = (4, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);  
say join q/ /, line_counts $s, @w;
