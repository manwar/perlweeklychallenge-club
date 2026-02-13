#include "alloc.h"
#include <time.h>

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s yyy-mm-dd", argv[0]);

    int y, m, d;
    if (sscanf(argv[1], "%d-%d-%d", &y, &m, &d) != 3)
        die("invalid date: %s", argv[1]);

    struct tm data = {0};
    data.tm_year = y - 1900;
    data.tm_mon = m - 1;
    data.tm_mday = d;

    if (mktime(&data) == (time_t)-1)
        die("invalid date: %s", argv[1]);

    printf("%d\n", data.tm_yday + 1);
}
