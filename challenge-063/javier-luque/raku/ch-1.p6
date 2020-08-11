# Test: perl6 ch-1.p6 -u
use Test;

# Hash to store unique emails
my %unique_emails;

sub MAIN() {
    is last_word('  hello world',                rx/[e|a]l/),      'hello',  'Hello world';
    is last_word("Don't match too much, Chet!",  rx:i/ch.t/),      'Chet!',  'Chet';
    is last_word("spaces in regexp won't match", rx/"in re"/),      Nil,     'Undef';
    is last_word( join(' ', 1..1e6),            rx/^^(3.*?)**3/), '399933',  'Numbers';
    done-testing;
}

# Check if the email is unique
sub last_word(Str $string, $regex)  {
    my @words = $string.split(/\s/).reverse;

    for (@words) -> $word {
    	return $word
    		if ($word ~~ $regex);
    }

    return Nil;
}
