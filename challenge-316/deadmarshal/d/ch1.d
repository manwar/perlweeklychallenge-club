import std.stdio;

bool circular(string[] arr)
{
  foreach(i;0..arr.length-2)
  {
    if(arr[i][$-1] != arr[i+1][0]) return false;
  }
  return true;
}

void main()
{
  writeln(circular(["perl","loves","scala"]));
  writeln(circular(["love","the","programming"]));
  writeln(circular(["java","awk","kotlin","node.js"]));
}

