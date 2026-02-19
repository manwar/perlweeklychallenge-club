#include "alloc.h"
#include <ctype.h>

#define NUM_BOXES 10

typedef struct {
    int red;
    int green;
    int blue;
} Box;

void fill_boxes(Box* boxes, const char* str) {
    memset(boxes, 0, NUM_BOXES * sizeof(Box));
    for (int i = 0; str[i] != '\0'; i += 2) {
        char color = str[i];
        char box_c = str[i+1];
        if (!isdigit(box_c))
            die("invalid box %c", box_c);
        int box = box_c - '0';
        switch (color) {
        case 'R': boxes[box].red++; break;
        case 'G': boxes[box].green++; break;
        case 'B': boxes[box].blue++; break;
        default: die("invalid color %c", color);
        }
    }
}

int count_boxes_3colors(Box* boxes) {
    int count = 0;
    for (int i = 0; i < NUM_BOXES; i++) {
        if (boxes[i].red > 0 &&
            boxes[i].green > 0 &&
            boxes[i].blue > 0) {
            count++;
        }
    }
    return count;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s box_fill_commands", argv[0]);

    Box boxes[NUM_BOXES];
    fill_boxes(boxes, argv[1]);
    int count = count_boxes_3colors(boxes);
    printf("%d\n", count);
}
