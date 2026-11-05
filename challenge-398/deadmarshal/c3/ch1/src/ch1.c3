module ch1;

fn int divisible_average(int[] arr)
{
  int sum;
  int count;
  foreach(e : arr)
  {
    if(e % 2 == 0 && e % 3 == 0)
    {
      sum += e;
      count++;
    }
  }
  return count == 0 ? 0 : sum / count;
}

