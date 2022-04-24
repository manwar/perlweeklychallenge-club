#!/usr/bin/env raku

sub MAIN(
    Str $url  = "https://raw.githubusercontent.com/manwar/perlweeklychallenge-club/master/data/dictionary.txt",
    Int :$min = 3,
    Int :$max = 5
) {
    my $dict = get-dict( $url );
    my %words-grouped-by-letter = group-words-by-letter( $dict, $min, $max );
    say find-panagram( %words-grouped-by-letter);
}

sub get-dict( Str $url ) returns Str {
    use HTTP::UserAgent;
    my $ua = HTTP::UserAgent.new;
    $ua.timeout = 5;
    my $response = $ua.get($url);
    my $dict = do with $response {
        .is-success ?? .content !! die .status-line
    }
}

sub group-words-by-letter(
    Str $dict, 
    Int $min,
    Int $max
) returns Hash {
    my %words-grouped-by-letter;
    for $dict.lines -> $word {
        next unless $min <= $word.chars <= $max;
        my %seen-letter;
        for $word.split('', :skip-empty) -> $w {
            next if defined  %seen-letter{$w};
            if defined %words-grouped-by-letter{$w} {
                %words-grouped-by-letter{$w}.push: $word;
            } else {
                %words-grouped-by-letter{$w} = [$word];
            }
            %seen-letter{$w} = 1;
        }
    }
    return %words-grouped-by-letter
}

sub find-panagram(
    %words-grouped-by-letter
) returns Array {
    my @panagram;
    my %have-letter;
    for 'a' ... 'z' -> $a {
        next if defined %have-letter{$a};
        for %words-grouped-by-letter{$a} -> @a-words {
            for @a-words.pick -> $word {
                for $word.split('', :skip-empty ) -> $w {
                    %have-letter{$w} = 1; 
                }
                @panagram.push: $word;
            }
        }
    }
    return @panagram;
}
