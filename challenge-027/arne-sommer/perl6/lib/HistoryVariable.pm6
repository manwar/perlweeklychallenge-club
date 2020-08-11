use v6.d;

class HistoryVariable
{
  has $!value;
  has @!history;

  multi method new
  {
    self.bless;
  }

  method set ($new-value)
  {
    $!value = $new-value;
    @!history.push( Pair(now.Int => $new-value) );
  }

  method gist
  {
    return $!value;
  }
  
  method get
  {
    return $!value;
  }

  multi method history ('time')
  {
    return @!history.map({ DateTime.new($_.key).local ~ ": " ~ $_.value }).join("\n");
}
  
  multi method history
  {
    return @!history.map( *.value );
  }
}

