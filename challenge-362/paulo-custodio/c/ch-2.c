#include "alloc.h"

// convert number to text
typedef struct {
    int bracket;
    const char* text;
} NumClass;

#define APPEND(out, text) do { \
            if (out->size > 0) str_append(out, " "); \
            str_append(out, text); \
        } while (0)

void number_to_text1(Str* out, int num) {
    if (num == 0) {
        APPEND(out, "zero");
        return;
    }

    if (num < 0) {
        APPEND(out, "minus");
        number_to_text1(out, -num);
        return;
    }

    static NumClass orders[] = {
        {1000000, "milion"},
        {1000, "thousand"},
        {100, "hundred"},
        {0, NULL},
    };

    for (int i = 0; orders[i].bracket != 0; i++) {
        if (num == orders[i].bracket) {
            number_to_text1(out, num / orders[i].bracket);
            APPEND(out, orders[i].text);
            return;
        }
        else if (num >= orders[i].bracket) {
            number_to_text1(out, num / orders[i].bracket);
            APPEND(out, orders[i].text);
            number_to_text1(out, num % orders[i].bracket);
            return;
        }
    }

    static NumClass classes[] = {
        {90, "ninety"},
        {80, "eighty"},
        {70, "seventy"},
        {60, "sixty"},
        {50, "fifty"},
        {40, "forty"},
        {30, "thirty"},
        {20, "twenty"},
        {19, "nineteen"},
        {18, "eighteen"},
        {17, "seventeen"},
        {16, "sixteen"},
        {15, "fifteen"},
        {14, "fourteen"},
        {13, "thirteen"},
        {12, "twelve"},
        {11, "eleven"},
        {10, "ten"},
        {9, "nine"},
        {8, "eight"},
        {7, "seven"},
        {6, "six"},
        {5, "five"},
        {4, "four"},
        {3, "three"},
        {2, "two"},
        {1, "one"},
        {0, NULL},
    };

    for (int i = 0; classes[i].bracket != 0; i++) {
        if (num == classes[i].bracket) {
            APPEND(out, classes[i].text);
            return;
        }
        else if (num >= classes[i].bracket) {
            APPEND(out, classes[i].text);
            number_to_text1(out, num - classes[i].bracket);
            return;
        }
    }

    assert(0);
}

Str* number_to_text(int num) {
    Str* out = str_new();
    number_to_text1(out, num);
    return out;
}

// sort numbers by text representation
typedef struct {
    int num;
    char* text;
} Num;

int compare(const void* a, const void* b) {
    return strcmp(((Num*)a)->text, ((Num*)b)->text);
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s nums...\n");

    argc--; argv++;
    Num* nums = xcalloc(argc, sizeof(Num));
    for (int i = 0; i < argc; i++) {
        int num = atoi(argv[i]);
        Str* text = number_to_text(num);
        nums[i].num = num;
        nums[i].text = xstrdup(text->body);
        str_free(text);
    }

    qsort(nums, argc, sizeof(Num), compare);

    printf("(");
    for (int i = 0; i < argc; i++) {
        if (i > 0)
            printf(", ");
        printf("%d", nums[i].num);
    }
    printf(")\n");

    for (int i = 0; i < argc; i++) {
        xfree(nums[i].text);
    }
    xfree(nums);
}
