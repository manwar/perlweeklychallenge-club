module string_difference;

import ch2;

fn void string_difference_test() @test
{
  assert(ch2::string_difference({"ab","bc","cd","zy"})!! == "zy");
  assert(ch2::string_difference({"cba","fed","azy"})!! == "azy");
  assert(ch2::string_difference({"pop","ada","beb","cfc"})!! == "pop");
  assert(ch2::string_difference({"aaaa","zzzz","mmmm","aaba"})!! == "aaba");
  assert(ch2::string_difference({"aceg","bdfh","cegi","azbz"})!! == "azbz");
}

