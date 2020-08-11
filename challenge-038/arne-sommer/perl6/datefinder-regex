#! /usr/bin/env raku

# subset month of Str where $_ eq any ("01" .. "12");
# subset day   of Str where $_ eq any ("01" .. "31");

unit sub MAIN (Str $date);

if $date ~~ /^
            $<century> = (<[12]>)
            $<year>    = (<[0..9]><[0..9]>)
	    $<month>   = (<[01]><[0..9]>)
	    $<day>     = (<[0123]><[0..9]>)
         $/
{
  my $datestring = "{ $<century> == 1 ?? '20' !! '19' }{ $<year> }-{ $<month> }-{ $<day> }";

  if try Date.new($datestring)
  {
    say $datestring;
    exit;
  }
}

say "Not a valid date.";
