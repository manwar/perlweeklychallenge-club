use strict; use warnings; use Test::More tests=>6;

sub percentage_of_char {
  my( $str, $char ) = @_;
  my $count = () = $str =~ /\Q$char/g;
  int( 0.5  +  100 * $count / length $str );
}

my @tests = <<'' =~ /"(.*?)".*?"(.*?)".*?(\d+)/g;
    Input: $str = "perl",      $char = "e" Output: 25
    Input: $str = "java",      $char = "a" Output: 50
    Input: $str = "python",    $char = "m" Output: 0
    Input: $str = "ada",       $char = "a" Output: 67
    Input: $str = "ballerina", $char = "l" Output: 22
    Input: $str = "analitik",  $char = "k" Output: 13

while( @tests ){
    my( $str, $char, $output) = splice @tests, 0, 3;
    my $p = percentage_of_char($str,$char);
    is $p, $output, sprintf "test str: %15s   char: %s   want: %2d   got: %2d", $str, $char, $output, $p;
}
