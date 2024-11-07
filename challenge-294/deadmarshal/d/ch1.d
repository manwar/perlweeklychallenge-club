import std.stdio:writeln;
import std.algorithm:max;

int consecutive_sequence(int[] arr)
{
  int res = 0;
  int[int] s;
  foreach(e;arr) s[e] = 1;
  foreach(e;arr){
    if(e-1 !in s){
      int j = e;
      while(j in s) j++;
      res = max(res,j - e);
    }
  }
  return res == 1 ? -1 : res;
}

void main()
{ 
  writeln(consecutive_sequence([10,4,20,1,3,2]));
  writeln(consecutive_sequence([0,6,1,8,5,2,4,3,0,7]));
  writeln(consecutive_sequence([10,30,20]));
}

