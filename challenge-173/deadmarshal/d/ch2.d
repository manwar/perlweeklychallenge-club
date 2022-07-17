import std.stdio:writeln;
import std.bigint;
import std.algorithm.iteration:reduce;

void main()
{
  BigInt[] arr = [2.BigInt,3.BigInt];
  do{
    arr ~= reduce!((a, b) => a * b)(1.BigInt,arr) + 1;
  }while(arr.length != 10);

  foreach(e; arr)
    writeln(e);
}
