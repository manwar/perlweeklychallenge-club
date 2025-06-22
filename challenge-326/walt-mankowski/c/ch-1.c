#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

void usage() {
    printf("Usage: ch-1 YYYY-MM-DD\n");
    exit(1);
}

int main(int argc, char *argv[]) {
    struct tm tm;
    if (argc != 2)
        usage();

    /* Make a copy of argv[1] so we can call strtok() on it */
    char *yyyymmdd = malloc(strlen(argv[1]) + 1);
    strcpy(yyyymmdd, argv[1]);

    /* parse the date and construct a struct tm with the year, month, and day */
    memset(&tm, 0, sizeof(tm));
    tm.tm_year = atoi(strtok(yyyymmdd, "-")) - 1900;
    tm.tm_mon = atoi(strtok(NULL, "-")) - 1;
    tm.tm_mday = atoi(strtok(NULL, "-"));

    /* get the epoch time for midnight on that date */
    time_t t = mktime(&tm);

    /* get the yday for that time */
    struct tm *new_tm = gmtime(&t);
    printf("%d\n", new_tm->tm_yday + 1);
}
