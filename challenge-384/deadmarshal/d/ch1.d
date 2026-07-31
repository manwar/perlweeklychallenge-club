import std.stdio;
import std.algorithm.mutation:reverse;

string base_n(uint num,uint base) {
  if(num == 0) return "0";
  string digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/";
  char[] res;

  for(uint n = num; n > 0; n /= base) {
    res ~= digits[n % base];
  }
  
  res.reverse();
  return cast(string)res;
}

void main() {
  writeln(base_n(42,2));
  writeln(base_n(15642094,16));
  writeln(base_n(493,8));
  writeln(base_n(2228519,36));
  writeln(base_n(123456789,64));
}
