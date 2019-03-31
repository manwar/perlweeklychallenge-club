perl -E '
  say for map {
    s/\d+/$&%5?$&:"$& buzz"/e;
    s/\d+/$&%3?$&:"fizz$&"/e;
    y/0-9//d if /\D/;
    s/^ //;
    $_;
  } 1 .. 20
'

perl -E '
  say for
    map @$_ > 1 ? join( $", splice @$_, 0, -1 ) : @$_,
    map [ $_->[-1] % 3 ? @$_ : ( fizz => @$_ ) ],
    map [ $_ % 5      ? $_  : ( buzz => $_ ) ],
    1 .. 20
'

perl -E '
  say for map
    $_ % 5 ? $_ % 3 ? $_
    : "fizz"
    : $_ % 3 ? "buzz"
    : "fizz buzz",
    1 .. 20
'

perl -E '
  say for map
    [ "fizz buzz" => buzz => fizz => $_ ]
      ->[ !!( $_ % 3 ) + !!( $_ % 5 ) * 2 ],
    1 .. 20
'

perl -E '
  say for map
    [ $_ => fizz => buzz => "fizz buzz" ]
    ->[ !( $_ % 3 ) + !( $_ % 5 ) * 2 ],
    1 .. 20
'

perl -E '
  say for map
    [ $_ => fizz => buzz => "fizz buzz" ]
    ->[ !( $_ % 3 ) + /[50]$/ * 2 ],
    1 .. 20
'
