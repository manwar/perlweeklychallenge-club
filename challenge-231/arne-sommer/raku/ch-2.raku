#! /usr/bin/env raku

grammar PassengerDetails
{
  token TOP   { ^ <phone> <sex> <age> <seat> $ }
  token phone { <[0..9]> ** 10 }
  token sex   { <[MF]> }
  token age   { <[0..9]> ** 2 }
  token seat  { <[0..9]> ** 2 }
}

sub MAIN (*@list where @list.elems > 0 && @list.map({ so PassengerDetails.parse($_) }), :v(:$verbose))
{
  my $senior = 0;

  for @list -> $passenger
  {
    my $p   = PassengerDetails.parse($passenger);
    my $age = $p<age>;

    if $age >= 60
    {
      say ": Passenger $passenger (age $age - senior)" if $verbose;
      $senior++;
    }
    elsif $verbose
    {
      say ": Passenger $passenger (age $age)";
    }
  }

  say $senior;
}
