unit module luca-ferrari::raku::task-two:ver<0.0.1>:auth<luca-ferrari@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/luca-ferrari/raku/ test/challenge-nr233/raku/task-two.rakutest

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@input) is export {
    my %sorting;
    for @input -> $current {
      my $frequency = @input.grep( * == $current ).elems;
      %sorting{ $frequency } //= Array.new;
      %sorting{ $frequency }.push: $current if ( ! %sorting{ $frequency }.grep( * == $current ) );
    }

    %sorting{ $_ }.sort.join( ',' ).say for %sorting.keys.sort;
}