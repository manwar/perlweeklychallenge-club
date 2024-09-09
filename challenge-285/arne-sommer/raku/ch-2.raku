#! /usr/bin/env raku

unit sub MAIN (UInt $amount, :v(:$verbose));

my %value;

%value<penny>       =  1;
%value<nickel>      =  5;
%value<dime>        = 10;
%value<quarter>     = 25;
%value<half-dollar> = 50;

my $ok = 0;

for 0 .. $amount -> $penny
{
  my $sum-p = $penny * %value<penny>;

  for 0 .. $amount -> $nickel
  {
    my $sum-pn = $sum-p + $nickel * %value<nickel>;

    last if $sum-pn > $amount;
 
    for 0 .. $amount -> $dime
    {
      my $sum-pnd = $sum-pn + $dime * %value<dime>;

      last if $sum-pnd > $amount;

      for 0 .. $amount -> $quarter
      {
        my $sum-pndq = $sum-pnd + $quarter * %value<quarter>;

        last if $sum-pndq > $amount;

        for 0 .. $amount -> $half-dollar
        {
          my $sum = $sum-pndq + $half-dollar * %value<half-dollar>;

          last if $sum > $amount;

          if $sum == $amount
	  {
	    $ok++;
	    say ": " ~
	    (
	      prettyish($penny,       'P'),
              prettyish($nickel,      'N'),
	      prettyish($dime,        'D'),
	      prettyish($quarter,     'Q'),
	      prettyish($half-dollar, 'HD')
            ).grep( *.defined ).join(" + ") if $verbose;
	  }
	}
      }
    }
  }
}

sub prettyish ($value, $letter)
{
  return unless $value;
  return $letter if $value == 1;
  return "$value$letter";
}

say $ok;
