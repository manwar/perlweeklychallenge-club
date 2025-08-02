
  
use v5.38;
use Time::Piece;
use Time::Seconds;

  
sub count_days{
    my($start, $offset, $holidays) = @_;
    $start = Time::Piece->strptime($start, q/%Y-%m-%d/);
    my $t = $start;
    my $end = $start;
    { 
      $t += ONE_DAY;
      unless(
$t->wday >= 6 
 || 
1 == grep {$t->strftime(q/%Y-%m-%d/) eq $_} @{$holidays}
){
         $end = $t; 
         $offset--;
      }
      redo if $offset > 0;
    }
    return $end->strftime(q/%Y-%m-%d/); 
}

  
MAIN:{
  say count_days q/2018-06-28/, 3, [q/2018-07-03/];
  say count_days q/2018-06-28/, 3;
}

