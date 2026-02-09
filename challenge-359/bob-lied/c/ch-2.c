#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void rmvPair(char *str)
{
    char *from = str;
    char *to   = str;

    while ( *from != '\0' )
    {
        if ( *from != *(from+1) ) { *to++ = *from++; }
        else                      { from++; from++;  }
    }
    *to = '\0';
}

void rmvAllPair(char *str)
{
    int n;
    do {
        n = strlen(str);
        rmvPair(str);
    }
    while ( strlen(str) < n );
}

int main(int argc, char *argv[])
{
    for ( int arg = 1; arg < argc; arg++ )
    {
        char str[256];
        strcpy(str, argv[arg]);

        rmvAllPair(str);
        puts(str);
    }

    exit(0);
}
