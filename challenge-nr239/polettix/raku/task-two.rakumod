unit module polettix::raku::task-two:ver<0.0.1>:auth<github:polettix>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr239/polettix/raku/ -- test/challenge-nr239/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr239 -- test/benchmark-scalability.raku --task=task-two --user=polettix --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr239; cat /tmp/nr239_task-two.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution([$allowed, *@str]) is export {
   my $al = $allowed.comb.Set;
   my &checker = sub ($input) {
      for $input.comb -> $c {
         return False unless $c ∈ $al;
      }
      return True;
   };
   @str.grep(&checker).elems;
}