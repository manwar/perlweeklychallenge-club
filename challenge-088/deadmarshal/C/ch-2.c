#include<stdio.h>
#include<stdlib.h>
#include<assert.h>

void spiral_matrix(size_t rows, size_t cols, const int mat[rows][cols])
{
  int i, k = 0, l = 0;
  int last_row = rows-1, last_col = cols-1;
  
  while(k <= last_row && l <= last_col)
  {
    for(i = l; i <= last_col; i++)
      printf("%d ", mat[k][i]);
    k++;

    for(i = k; i <= last_row; i++)
      printf("%d ", mat[i][last_col]);
    last_col--;

    if(k <= last_row)
    {
      for(i = last_col; i >= l; i--)
	printf("%d ", mat[last_row][i]);
      last_row--;
    }
    if(l <= last_col)
    {
      for(i = last_row; i >= k; i--)
	printf("%d ", mat[i][l]);
      l++;
    }
  }
}

int main(void)
{
  
  int arr[3][3] = {
    { 1, 2, 3 },
    { 4, 5, 6 },
    { 7, 8, 9 }
  };
  
  int arr2[4][4] = {
    {  1,  2,  3,  4 },
    {  5,  6,  7,  8 },
    {  9, 10, 11, 12 },
    { 13, 14, 15, 16 }
  };
  
  spiral_matrix(3, 3, arr);
  puts("");
  spiral_matrix(4, 4, arr2);
  puts("");
    
  return 0;
}
