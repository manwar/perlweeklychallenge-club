# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o
 */

int main (void) {
    int i;
    printf ("%lld\n", (long long) &i); /* %p is specific for printing     */
                                       /* memory addresses, but does this */
                                       /* using hex numbers. So we cast   */
                                       /* the address to long long and    */
                                       /* print that.                     */
    return (0);
}
