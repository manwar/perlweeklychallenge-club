# include <stdlib.h>
# include <stdio.h>

void process (int n, int u, int d, char * prefix) {
    if (d == n) {
        printf ("%s ", prefix);
    }
    if (d < u) {
        char * tmp;
        if ((tmp = (char *) malloc ((u + d + 2) * sizeof (char))) == NULL) {
            perror ("malloc failed");
            exit (1);
        }
        for (int i = 0; i < u + d; i ++) {
            tmp [i] = prefix [i];
        }
        tmp [u + d]     = 'D';
        tmp [u + d + 1] = '\0';
        process (n, u, d + 1, tmp);
    }
    if (u < n) {
        char * tmp;
        if ((tmp = (char *) malloc ((u + d + 2) * sizeof (char))) == NULL) {
            perror ("malloc failed");
            exit (1);
        }
        for (int i = 0; i < u + d; i ++) {
            tmp [i] = prefix [i];
        }
        tmp [u + d]     = 'U';
        tmp [u + d + 1] = '\0';
        process (n, u + 1, d, tmp);
    }
}

int main (int argc, char ** argv) {
    char *  line    = NULL;
    size_t  linecap = 0;
    ssize_t linelen;
    while ((linelen = getline (&line, &linecap, stdin)) > 0) {
        int n = atoi (line);
        char * prefix = "";
        process (n, 0, 0, prefix);
        printf ("\n");
    }
    exit (0);
}
