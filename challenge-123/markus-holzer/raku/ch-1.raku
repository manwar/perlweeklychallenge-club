# Write a script to find the $Nth element of "Ugly Numbers"

unit sub MAIN( Int $N );

sub factors( Int $n ) {
  if $n > 1 {
    $_, |factors $n div $_
      given ( grep $n %% *, 2..* ).first } }

say ( 1, |grep *.&factors.all ∈ ( 2, 3, 5 ), 2..* )[ $N ];