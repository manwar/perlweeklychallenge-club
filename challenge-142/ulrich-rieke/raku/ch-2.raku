use v6 ;

say "Enter a number of positive integers!" ;
my $line = $*IN.get ;
my @numbers = $line.split( /\s+/ ).map( { .Int } ) ;
my @threads = @numbers.map: {
  Thread.start(
      sub {
        my $num = @numbers.pick ;
    sleep $num ;
    say $num ;
      },
  );
}
.finish for @threads ;
