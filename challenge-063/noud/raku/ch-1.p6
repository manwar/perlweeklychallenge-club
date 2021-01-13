# Define sub last_word($string, $regexp) that returns the last word matching
# $regexp found in the given string, or undef if the string does not contain a
# word matching $regexp.
#
# For this challenge, a “word” is defined as any character sequence consisting
# of non-whitespace characters (\S) only. That means punctuation and other
# symbols are part of the word.
#
# The $regexp is a regular expression. Take care that the regexp can only match
# individual words! See the Examples for one way this can break if you are not
# careful.
#
# Examples
#
# last_word('  hello world',                qr/[ea]l/);      # 'hello'
# last_word("Don't match too much, Chet!",  qr/ch.t/i);      # 'Chet!'
# last_word("spaces in regexp won't match", qr/in re/);      #  undef
# last_word( join(' ', 1..1e6),             qr/^(3.*?){3}/); # '399933'

sub last_word($string, $regexp) {
    for $string.words.reverse -> $word {
        return $word if $word ~~ $regexp;
    }
}


last_word('  hello world', rx/<[ea]>l/).say;
last_word("Don't match too much, Chet!",  rx:i/ch.t/).say;
last_word("spaces in regexp won't match", rx:s/in re/).say;
last_word(1..1e6.join(' '), rx/^(3.*?)**3/).say;
