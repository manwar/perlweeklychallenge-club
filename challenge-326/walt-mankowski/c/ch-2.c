#include <stdio.h>
#include <stdlib.h>

size_t compute_output_len(int argc, char *argv[]) {
    size_t output_len = 0;
    for (int i = 1; i < argc; i += 2)
        output_len += atoi(argv[i]);

    return output_len;
}

int main (int argc, char *argv[]) {
    if (argc % 2 != 1) {
        fputs("There should be an even number of parameters\n", stderr);
        exit(1);
    }

    /* compute how big the output array should be */
    size_t output_len = compute_output_len(argc, argv);
    unsigned int *output = malloc(output_len * sizeof(unsigned int));

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
    for (int i = 0; i < output_len-1; i++)
        printf("%u, ", output[i]);
    printf("%u)\n", output[output_len-1]);
}
