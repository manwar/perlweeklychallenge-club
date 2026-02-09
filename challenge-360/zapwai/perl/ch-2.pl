use v5.38;

sub proc($str) {
    say "Input: \$str = $str";
    my @word = split ' ', $str;
    my @words = sort {fc($a) cmp fc($b)} @word;
    my @num = grep {/\d/} @words;
    @num = sort { $a <=> $b } @num;
    my @just_words = grep {/\D/} @words;
    say "Output: @num @just_words";
    
}

my $str = "The quick brown fox";
proc($str);
$str = "Hello    World!   How   are you?";
proc($str);
$str = "Hello";
proc($str);
$str = "Hello, World! How are you?";
proc($str);
$str = "I have 2 apples and 3 bananas!";
proc($str);
