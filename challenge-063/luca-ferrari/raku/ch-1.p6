#!env raku


# Define sub last_word($string, $regexp) that returns the last word matching $regexp found in the given string, or undef if the string does not contain a word matching $regexp.
# 
# For this challenge, a “word” is defined as any character sequence consisting of non-whitespace characters (\S) only. That means punctuation and other symbols are part of the word.
# 
# The $regexp is a regular expression. Take care that the regexp can only match individual words! See the Examples for one way this can break if you are not careful.
# Examples
# 
# last_word('  hello world',                qr/[ea]l/);      # 'hello'
# last_word("Don't match too much, Chet!",  qr/ch.t/i);      # 'Chet!'
# last_word("spaces in regexp won't match", qr/in re/);      #  undef
# last_word( join(' ', 1..1e6),             qr/^(3.*?){3}/); # '399933'
# 



sub last_word( $string, $regexp ){
    my $last-word = Nil;
    for $string.split( " " ) {
        $last-word =  $_ if $_ ~~ $regexp;
    }

    return $last-word;
}


sub last_word_shorter( $string, $regexp ){
    for $string.split( " " ).reverse {
        return $_ if $_ ~~ $regexp;
    }
}


sub MAIN(){
    say last_word('  hello world',                rx/<[ea]>l/);      # 'hello'
    say last_word("Don't match too much, Chet!",  rx:i/ch.t/);      # 'Chet!'
    say last_word("spaces in regexp won't match", rx:s/ in re / );      #  undef
    say last_word( join(' ', 1..1e6),             rx/ ^ (3.*?) ** 3 / ); # '399933'

    say last_word_shorter('  hello world',                rx/<[ea]>l/);      # 'hello'
    say last_word_shorter("Don't match too much, Chet!",  rx:i/ch.t/);      # 'Chet!'
    say last_word_shorter("spaces in regexp won't match", rx:s/ in re / );      #  undef
    say last_word_shorter( join(' ', 1..1e6),             rx/ ^ (3.*?) ** 3 / ); # '399933'
}
