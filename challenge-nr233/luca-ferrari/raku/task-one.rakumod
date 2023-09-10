unit module luca-ferrari::raku::task-one:ver<0.0.1>:auth<luca-ferrari@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/luca-ferrari/raku/ test/challenge-nr233/raku/task-one.rakutest

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@input) is export {
	my %similars;
    for @input -> $word {
	  my $key = $word.comb.sort.join;
	  %similars{ $key }.push: $word;
    }
    
    %similars.values.grep( *.elems > 1 );
}