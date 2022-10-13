use v6 ;

sub zip ( @lista , @listb ) {
  return (@lista Z @listb).flat ;
}

say "Please enter a list of letters or numbers ( all separated by blanks)!" ;
my $line = $*IN.get ;
my @firstArray = $line.split( /\s+/ ) ;
say "Enter another list of letters or numbers!" ;
$line = $*IN.get ;
my @secondArray = $line.split( /\s+/ ) ;
say zip( @firstArray, @secondArray ) ;
