unit module ulrich-rieke::raku::task-two:ver<0.0.1>:auth<ulrich-rieke@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/ulrich-rieke/raku/ -- test/challenge-nr233/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr233 -- test/benchmark-scalabiity.raku --task=task-two --user=ulrich-rieke --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr233; cat /tmp/nr233_task-two.csv

sub count( @array , $element ) {
   return @array.grep( {$_ == $element} ).elems ;
}

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@numbers) is export {

    my @uniques = @numbers.unique ;
    my %frequencies ;
    for @uniques -> $num {
       %frequencies{ $num } = count( @numbers , $num ) ;
    }
    my @sorted = @uniques.sort( { %frequencies{$^a} <=> %frequencies{$^b} || 
          $^b <=> $^a } ) ;
    my @result ;
    for @sorted -> $num {
       for (1..%frequencies{ $num } ) {
          @result.push( $num ) ;
       }
    }
    @result.List;
}