unit module packy-anderson::raku::task-one:ver<0.0.1>:auth<github:packy-anderson>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr239/packy-anderson/raku/ -- test/challenge-nr239/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr239 -- test/benchmark-scalability.raku --task=task-one --user=packy-anderson --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr239; cat /tmp/nr239_task-one.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@input) is export {
  my ($same, $words) = sameString(@input[0].Array, @input[1].Array);
  $same ?? True !! False;
}

sub sameString(@arr1, @arr2) {
  my ($word1, $words1) = concatString(1, @arr1);
  my ($word2, $words2) = concatString(2, @arr2);
  return($word1 eq $word2, $words1 ~ $words2);
}

sub concatString($num, @arr) {
  my $word = [~] @arr;
  my $words = "\nUsing \@arr$num, word$num => \""
            ~ @arr.join('" . "')
            ~ '" => "' ~ $word ~ '"';
  return ($word, $words);
}