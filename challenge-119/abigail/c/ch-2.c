# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */
# define BUF_SIZE 32
int main (void) {
    int num;
    char number [BUF_SIZE + 1];

    number [BUF_SIZE] = '\0';

    while (scanf ("%d", &num) == 1) {
        /*
         * Set the string to all 0s
         */
        for (int i = 0; i < BUF_SIZE; i ++) {
            number [i] = '0';
        }
        while (num --) {
            int i;
            /*
             * All trailing 3s will be turned into 1s
             */
            for (i = BUF_SIZE - 1; i > 0 && number [i] == '3'; i --) {
                number [i] = '1';
            }
            /*
             * Increment the digit before the trailing 3s
             */
            number [i] ++;

            /*
             * Replace any '11' by '12'
             */
            for (i = 0; i < BUF_SIZE - 1; i ++) {
                if (number [i] == '1' && number [i + 1] == '1') {
                    number [i + 1] = '2';
                }
            }
        }
        /*
         * Print the number, without the leading 0s
         */
        int i;
        for (i = 0; i < BUF_SIZE && number [i] == '0'; i ++);
        printf ("%s\n", number + i);
    }

    return (0);
}
