#include <stdio.h>
#include <stdlib.h>

struct Box {
    int width;
    int height;
};

struct Chain {
    int *boxes;
    int length;
};


// Return the longest chain beginning with box 'key'.
struct Chain follow(int key, int m, struct Box box[m])
{
    struct Chain best = {NULL, 0};

    for (int next = 0; next < m; next++) {

        if (box[next].width <= box[key].width ||
            box[next].height <= box[key].height)
            continue;

        struct Chain subchain = follow(next, m, box);

        if (subchain.length > best.length) {

            free(best.boxes);

            best.length = subchain.length;
            best.boxes = malloc(best.length * sizeof(int));

            for (int i = 0; i < best.length; i++)
                best.boxes[i] = subchain.boxes[i];
        }

        free(subchain.boxes);
    }


     // Put key at the beginning of the best chain.
    int *result = malloc((best.length + 1) * sizeof(int));

    result[0] = key;

    for (int i = 0; i < best.length; i++)
        result[i + 1] = best.boxes[i];

    free(best.boxes);

    best.boxes = result;
    best.length++;

    return best;
}


void proc(int m, struct Box box[m])
{
    printf("Input: Boxes = ");

    for (int i = 0; i < m; i++)
        printf("[%d, %d] ", box[i].width, box[i].height);

    printf("\n");

    int max = 0;
    int *max_chain = NULL;

    //Try every box as the beginning of a chain.
    for (int i = 0; i < m; i++) {

        struct Chain chain = follow(i, m, box);

        if (chain.length > max) {

            free(max_chain);

            max = chain.length;
            max_chain = malloc(max * sizeof(int));

            for (int j = 0; j < max; j++)
                max_chain[j] = chain.boxes[j];
        }

        free(chain.boxes);
    }

    printf("Output: %d\n", max);
    printf("Maximal Chain: ");

    for (int i = 0; i < max; i++) {
        int k = max_chain[i];

        printf("[%d,%d] ",
               box[k].width,
               box[k].height);
    }

    printf("\n");

    free(max_chain);
}


int main()
{
    int m = 4;
    struct Box box[] = {
        {1,3},
        {3,5},
        {6,8},
        {2,4}
    };
    proc(m, box);

    m = 5;
    struct Box box2[] = {
        {4,5},
        {4,6},
        {6,7},
        {2,3},
        {4,3}
    };
    proc(m, box2);

    m = 3;
    struct Box box3[] = {
        {5,5},
        {5,5},
        {5,5}
    };
    proc(m, box3);

    m = 5;
    struct Box box4[] = {
        {2,100},
        {3,200},
        {4,300},
        {5,50},
        {5,400}
    };
    proc(m, box4);

    struct Box box5[] = {
        {10,20},
        {15,10},
        {20,30},
        {12,18},
        {16,25}
    };
    proc(5, box5);
}
