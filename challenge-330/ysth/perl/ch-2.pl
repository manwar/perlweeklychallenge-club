use 5.036;
use utf8::all;

sub title_capital($string) {
    join ' ', map { /^\X{3}/ ? ucfirst lc : lc } split / /, $string
}

my @inputs = @ARGV;
for my $string (@inputs) {
    printf "%-30s -> %s\n", $string, title_capital($string);
}
