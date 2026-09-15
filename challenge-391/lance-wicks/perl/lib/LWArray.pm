package LWArray;
use utf8;
use Moo;
use POSIX;

sub mean {
  my $self = shift;
  my @array = @_;

  @array = sort {$a <=> $b} @array;

  my $count = scalar @array;
  my $sum = 0;

  if ($count == 0) {
    return undef;
  }

  if ($count == 1 ) {
    return $array[0];
  }

  if ($count == 2) {
    map {$sum += $_ } @array;
    return $sum / $count;
  }

  unless ($count % 2) {
    my $middle =  floor($count/2);
    map { $sum += $_ } ($array[$middle],$array[$middle-1]);
    return $sum/2;

  } else {
    my $middle =  floor($count/2);
    return $array[$middle];
  }

}

1;
