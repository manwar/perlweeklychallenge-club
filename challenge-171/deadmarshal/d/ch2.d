import std.stdio:writeln;
import std.functional:compose;

auto f = (int n) => n + 2;
auto g = (int n) => n * 2;

void main()
{
  writeln(compose!(f, g)(5));
}
