import std.stdio:writeln,write;

int divisors_sum(int n)
{
  int sum = 0;
  for(int i = 1; i < n / 2+1; ++i)
    if(n % i == 0) sum += i;
  return sum;
}

int[] abundant_odd_numbers()
{
  int[] arr;
  int i = 1;
  do{
    if((divisors_sum(i) > i) && (i % 2 != 0)) arr ~= i;
    i++;
  }while(arr.length != 20);
  return arr;
}

void main()
{
  int[] arr = abundant_odd_numbers();
  foreach(e; arr)
    write(e, ' ');
  writeln;
}
