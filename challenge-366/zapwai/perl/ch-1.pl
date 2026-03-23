use v5.38;

sub proc($str, @a) {
    say "Input: \$str = $str, \@array = @a";
    my $cnt = grep { $str =~ /^$_/} @a;
    say "Output: $cnt";
}

my @array = ("a", "ap", "app", "apple", "banana");
my $str = "apple";
proc($str, @array);

@array = ("cat", "dog", "fish"); $str = "bird";
proc($str, @array);
@array = ("hello", "he", "hell", "heaven", "he"); $str = "hello";
proc($str, @array);
@array = ("", "code", "coding", "cod"); $str = "coding";
proc($str, @array);
@array = ("p", "pr", "pro", "prog", "progr", "progra", "program"); $str = "program";
proc($str, @array);
