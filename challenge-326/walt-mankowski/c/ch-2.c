#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[]) {
    if (argc % 2 != 1) {
        fputs("There should be an even number of parameters\n", stderr);
        exit(1);
    }

    /* compute how big the output array should be */
    size_t output_size = 0;
    for (int i = 1; i < argc; i += 2)
        output_size += atoi(argv[i]);
    int *output = malloc(output_size * sizeof(int));

    /* add things to the output array */
    int k = 0;
    for (int i = 1; i < argc; i += 2) {
        int cnt = atoi(argv[i]);
        int val = atoi(argv[i+1]);
        for (int j = 0; j < cnt; j++)
            output[k++] = val;
    }

    /* print out the array */
    printf("(");
    for (int i = 0; i < output_size-1; i++)
        printf("%d, ", output[i]);
    printf("%d)\n", output[output_size-1]);        
}
