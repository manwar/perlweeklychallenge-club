/*
Challenge 181

Task 2: Hot Day
Submitted by: Mohammad S Anwar

You are given file with daily temperature record in random order.

Write a script to find out days hotter than previous day.
Example

Input File: (temperature.txt)

2022-08-01, 20
2022-08-09, 10
2022-08-03, 19
2022-08-06, 24
2022-08-05, 22
2022-08-10, 28
2022-08-07, 20
2022-08-04, 18
2022-08-08, 21
2022-08-02, 25

Output:
2022-08-02
2022-08-05
2022-08-06
2022-08-08
2022-08-10
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

struct data {
    long jd;        // julian day
    int temp;       // temperature
};

struct data* data = NULL;
int data_size = 0;

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

// https://pdc.ro.nu/jd-code.html
long gregorian_date_to_jd(int y, int m, int d) {
    y += 8000;
    if (m < 3) { y--; m += 12; }
    return (y * 365) + (y / 4) - (y / 100) + (y / 400) - 1200820
        + (m * 153 + 3) / 5 - 92 + d - 1;
}

void jd_to_gregorian_date(long jd, int* yp, int* mp, int* dp) {
    int y, m, d;
    for (y = jd / 366 - 4715; gregorian_date_to_jd(y + 1, 1, 1) <= jd; y++);
    for (m = 1; gregorian_date_to_jd(y, m + 1, 1) <= jd; m++);
    for (d = 1; gregorian_date_to_jd(y, m, d + 1) <= jd; d++);
    *yp = y; *mp = m; *dp = d;
}

void read_data(const char* filename) {
    FILE* fp = fopen(filename, "r");
    if (fp == NULL) {
        perror(filename);
        exit(EXIT_FAILURE);
    }

    char line[BUFSIZ];
    while (fgets(line, sizeof(line), fp)) {
        int y,m,d,t;
        if (sscanf(line, "%d-%d-%d, %d", &y, &m, &d, &t) != 4) {
            fprintf(stderr, "cannot parse: %s\n", line);
            exit(EXIT_FAILURE);
        }
        struct data d1;
        d1.jd = gregorian_date_to_jd(y, m, d);
        d1.temp = t;

        data_size++;
        data = check_mem(realloc(data, data_size*sizeof(struct data)));
        data[data_size-1] = d1;
    }

    fclose(fp);
}

int compare(const void* a, const void* b) {
    return ((struct data*)a)->jd - ((struct data*)b)->jd;
}

void print_hot_days() {
    qsort(data, data_size, sizeof(struct data), compare);
    for (int i = 1; i < data_size; i++) {
        if (data[i].temp > data[i-1].temp) {
            int y, m, d;
            jd_to_gregorian_date(data[i].jd, &y, &m, &d);
            printf("%04d-%02d-%02d\n", y, m, d);
        }
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fputs("usage: ch-2 temperature-file\n", stderr);
        return EXIT_FAILURE;
    }

    read_data(argv[1]);
    print_hot_days();
    free(data);
}
