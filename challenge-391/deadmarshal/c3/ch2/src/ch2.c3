module ch2;

import std::sort;
import std::core::mem::alloc;

struct Box
{
  int width,height;
}

fn int Box.compare_to(self,Box other)
{
  return self.width != other.width
	   ? self.width - other.width
	   : other.height - self.height;
}

fn int arrange_box(Allocator allocator,Box[] boxes)
{
  if(boxes.len == 0) return 0;

  quicksort(boxes);
  
  int[] dp = alloc::new_array(allocator,int,boxes.len);
  defer alloc::free(allocator,dp);
  foreach(&d : dp) *d = 1;
  
  int max = 1;
  for(sz i = 0; i < boxes.len; i++)
  {
    for(sz j = 0; j < i; j++)
    {
      if(boxes[j].width < boxes[i].width &&
	 boxes[j].height < boxes[i].height &&
	 dp[j] + 1 > dp[i])
      {
	dp[i] = dp[j] + 1;
	if(dp[i] > max) max = dp[i];
      }
    }
  }
  return max;
}

fn int main(String[] args)
{
  
  return 0;
}

