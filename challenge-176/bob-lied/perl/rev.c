#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <time.h>

void reverse(char s[])
{
     int i, j;
     char c;

     for (i = 0, j = strlen(s)-1; i<j; i++, j--) {
         c = s[i];
         s[i] = s[j];
         s[j] = c;
     }
}  

int rev1(int n)
{
    int r = n % 10;
    while ( (n = n / 10) != 0 )
    {
        r = r*10 + n % 10;
    }
    return r;
}

int rev2(int n)
{
    char s[16];
    sprintf(s, "%d", n);
    reverse(s);
    return ( atoi(s) );
}

int main(int argc, char **argv)
{
    int r;

    const int start = 123400000;
    const int end   = 123500000;

    clock_t begin = clock();
    for ( int n = start; n <= end; n++ )
    {
        r = rev1(n);
    }
    clock_t finish = clock();
    double t = (double)(finish - begin) / CLOCKS_PER_SEC;
    printf("rev numeric %d %f\n", r, t);

    begin = clock();
    for ( int n = start; n <= end; n++ )
    {
        r = rev2(n);
    }
    finish = clock();
    t = (double)(finish - begin) / CLOCKS_PER_SEC;
    printf("rev string %d %f\n", r, t);
}
