#include "../../../challenge-001/paulo-custodio/c/alloc.h"

#define DAY (24*60*60)

bool is_holiday(time_t date, int num_holidays, time_t* holidays) {
    for (int i = 0; i < num_holidays; i++) {
        if (holidays[i] == date)
            return true;
    }
    return false;
}

time_t parse_date(const char* str) {
    int year, month, day;
    if (sscanf(str, "%d-%d-%d", &year, &month, &day) != 3)
        die("invalid date: %s", str);
    struct tm tm = {0};
    tm.tm_year = year - 1900;
    tm.tm_mon = month - 1;
    tm.tm_mday = day;
    time_t date = mktime(&tm);
    if (date == (time_t)-1)
        die("invalid date: %s", str);
    return date;
}

time_t calc_working_days(time_t date, int days, int num_holidays, time_t* holidays) {
    for (int i = 0; i < days; i++) {
        date += DAY;
        struct tm *tm = gmtime(&date);
        bool holiday = is_holiday(date, num_holidays, holidays);
        bool weekend = (tm->tm_wday == 0 || tm->tm_wday == 6);
        if (holiday || weekend)
            i--;
    }
    return date;
}

int main(int argc, char* argv[]) {
    if (argc < 3)
        die("usage: %s yyyy-mm-dd days [holidays]...", argv[0]);

    time_t start_date = parse_date(argv[1]);
    int days = atoi(argv[2]);
    int num_holidays = argc - 3;
    time_t* holidays = xmalloc(num_holidays * sizeof(time_t));
    for (int i = 0; i < num_holidays; i++)
        holidays[i] = parse_date(argv[i+3]);

    time_t end_date = calc_working_days(start_date, days, num_holidays, holidays);

    struct tm* tm = gmtime(&end_date);
    printf("%4d-%02d-%02d\n", tm->tm_year+1900, tm->tm_mon+1, tm->tm_mday);

    xfree(holidays);
}
