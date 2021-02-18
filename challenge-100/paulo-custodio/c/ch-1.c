/*
Challenge 100

TASK #1 > Fun Time
Submitted by: Mohammad S Anwar
You are given a time (12 hour / 24 hour).

Write a script to convert the given time from 12 hour format to 24 hour format
and vice versa.

Ideally we expect a one-liner.

Example 1:
Input: 05:15 pm or 05:15pm
Output: 17:15
Example 2:
Input: 19:15
Output: 07:15 pm or 07:15pm
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <ctype.h>

typedef struct Time {
    int hours, minutes;
    bool is12;
} Time;

bool parse_time(Time* time, const char* text) {
    char buffer[BUFSIZ];
    time->hours = time->minutes = 0;
    time->is12 = false;
    buffer[0] = '\0';

    if (!sscanf(text, "%d:%d %s", &time->hours, &time->minutes, buffer))
        return false;

    switch (tolower(buffer[0])) {
    case 'a':
        if (time->hours == 12) time->hours = 0;
        time->is12 = true;
        break;
    case 'p':
        if (time->hours != 12) time->hours += 12;
        time->is12 = true;
        break;
    case '\0':
        break;
    default:
        return false;
    }

    return true;
}

void print_time24(int hours, int minutes) {
    printf("%02d:%02d", hours, minutes);
}

void print_time12(int hours, int minutes) {
    bool ispm = false;
    if (hours == 0)
        hours = 12;
    else if (hours == 12)
        ispm = true;
    else if (hours > 12) {
        ispm = true;
        hours -= 12;
    }
    print_time24(hours, minutes);
    if (ispm)
        printf("pm");
    else
        printf("am");
}

int main(int argc, char* argv[]) {
    Time time;
    if (argc != 2 || !parse_time(&time, argv[1])) {
        fputs("Usage: ch-1 time", stderr);
        return EXIT_FAILURE;
    }
    if (time.is12)
        print_time24(time.hours, time.minutes);
    else
        print_time12(time.hours, time.minutes);
}
