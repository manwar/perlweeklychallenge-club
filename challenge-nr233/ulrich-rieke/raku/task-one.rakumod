unit module ulrich-rieke::raku::task-one:ver<0.0.1>:auth<ulrich-rieke@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/ulrich-rieke/raku/ -- test/challenge-nr233/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr233 -- test/benchmark-scalabiity.raku --task=task-one --user=ulrich-rieke --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr233; cat /tmp/nr233_task-one.csv

sub pairs( $n is copy ) {
   my $result ;
   if ( $n == 0 || $n == 1 ) {
      $result = 0 ;
   }
   if ( $n == 2 ) {
      $result = 1 ;
   }
   if ( $n > 2 ) {
      $result = findCombinations( $n ) ;
   }
   return $result ;
}

sub findCombinations( $num is copy ) {
   my $numerator = [*](1..$num) ;
   my $denom = [*]( 1..($num - 2)) ;
   return $numerator div ( $denom * 2 ) ;
}

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@words) is export {
	my @letters_in_word = @words.map( {$_.comb.unique.sort} ) ;#unique letters
	my %frequencies;
	for @letters_in_word -> $word {
	   %frequencies{ $word }++ ;#find the number of unique combination per combi
	}
	my $pairnumber = 0 ;
	for %frequencies.values -> $v {
	   $pairnumber += pairs( $v ) ;
	}
	$pairnumber ;
}