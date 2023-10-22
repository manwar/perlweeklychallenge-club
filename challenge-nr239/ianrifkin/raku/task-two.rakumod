unit module ianrifkin::raku::task-two:ver<0.0.1>:auth<github:ianrifkin>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr239/ianrifkin/raku/ -- test/challenge-nr239/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr239 -- test/benchmark-scalability.raku --task=task-two --user=ianrifkin --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr239; cat /tmp/nr239_task-two.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution([$allowed, *@str]) is export {
    my $success_count = 0;
    # Loop through each item in array of strings
  item_loop: for @str {
      # Loop through each character in string to check in allowed list
    letters_loop: for $_.comb -> $letter {
    LAST if $allowed.contains($letter) {
        $success_count++; #increment success if the last letter is in allowed list
    }
    # try next str item if a letter doesn't match
    letters_loop.last unless $allowed.contains($letter);

    # by default if letter matches and isn't last try next letter
    }
  }
  $success_count;
}