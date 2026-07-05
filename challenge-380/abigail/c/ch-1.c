# include <stdlib.h>
# include <stdio.h>

int isvowel (char ch) {
    return (ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u');
}

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        int count ['z' - 'a' + 1];
        for (char ch = 'a'; ch <= 'z'; ch ++) {
            count [ch - 'a'] = 0;
        }
        char * ptr = line;
        while (* ptr) {
            if ('a' <= * ptr && * ptr <= 'z') {
                count [* ptr - 'a'] ++;
            }
            ptr ++;
        }
        int max_c = 0;
        int max_v = 0;
        for (char ch = 'a'; ch <= 'z'; ch ++) {
            int * cmp = isvowel (ch) ? &max_v : &max_c;
            int c     = count [ch - 'a'];
            if (* cmp < c) {
                * cmp = c;
            }
        }
        printf ("%d\n", max_c + max_v);
    }
    free (line);
    exit (0);
}
