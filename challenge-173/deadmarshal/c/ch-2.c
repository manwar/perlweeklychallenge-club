#include<gmp.h>

// Sylvester’s sequence
#define N 10

void array_init(mpz_t *arr, size_t size)
{
  for(int i = 0; i < size; ++i)
    mpz_init(arr[i]);
}

void array_set(mpz_t *arr, size_t size)
{
  mpz_set_ui(arr[0], 2);
  mpz_set_ui(arr[1], 3);
  for(int i = 2; i < N; ++i)
    mpz_set_ui(arr[i], 1);
}

void array_mul(mpz_t *arr, size_t size)
{
  int k = 2;
  for(int i = 2; i < N; ++i)
  {
    for(int j = 0; j < k; ++j)
      mpz_mul(arr[k], arr[k], arr[j]);
    mpz_add_ui(arr[k], arr[k], 1);
    k++;
  }
}

void array_print(mpz_t *arr, size_t size)
{
  for(int i = 0; i < N; ++i)
    gmp_printf("%Zd\n", arr[i]); 
}

void array_free(mpz_t *arr, size_t size)
{
  for(int i = 0; i < N; ++i)
    mpz_clear(arr[i]);  
}

int main(void)
{
  mpz_t arr[N];
  array_init(arr, N);
  array_set(arr, N); 
  array_mul(arr, N);
  array_print(arr, N);
  array_free(arr, N);
  return 0;
}
