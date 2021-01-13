use v6;

say "hello";

sub LeaderElement(@array = (9,10,7,5,6,1)) {
    my $i = 0;
    my $l = elems(@array);
    my @result = [];
    for @array -> $elem {
      my @gt;  
      for @array[$i..$l-1] -> $e {
        #say $e < $elem;
        if ($elem > $e) {@gt.append(0)};
      }
      if (elems(@gt) == $l-$i-1) {@result.append($elem)};
      $i += 1;
    }
    return @result;
}

say LeaderElement((9,10,4,3,6,2,1));