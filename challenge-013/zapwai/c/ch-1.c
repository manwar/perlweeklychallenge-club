#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

bool is_leap_year (int year) {
  if (year % 400 == 0)
    return true;
  if (year % 100 == 0)
    return false;
  if (year % 4  == 0)
    return true;
  return false;
}

char* days_to_date(int days, int year) {
  if (days > 365)
    return "erroneous number of days\n";
  days += 1;
  int d[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
  if (is_leap_year(year))
    d[1] += 1;
  int month = 0;

  while (days > d[month]) {
    days -= d[month];
    month += 1;    
  }
  month += 1;
  char output[11];
  if (month < 10)
    output[0] = '0';
  else
    output[0] = '1';
  sprintf(&output[1], "%d", month % 10);
  output[2] = '-';
  if (days < 10)
    output[3] = '0';
  else if (days < 20)
    output[3] = '1';
  else
    output[3] = '2';
  sprintf(&output[4], "%d", days % 10);
  output[5] = '-';
  output[6] = '\0';
  char* date = malloc(11 * sizeof(char));
  strcat(date, output);
  char yr[5];
  sprintf(yr, "%d", year);
  strcat(date, yr);
  return date;
}

void fridays(int year) {
  char* day[] = { "sat", "sun", "mon", "tue", "wed", "thu", "fri" };
  int base_year = 2000;
  int skip_days = year - base_year;
  for (int yr = base_year; yr < year - 1; yr++)
    if (is_leap_year(yr))
      skip_days++;
  int first_fri_delta = 0;
  while (strcmp("fri", day[(skip_days + first_fri_delta)%7]) != 0)
    first_fri_delta++;
  int n = first_fri_delta;
  char* last_fridays[12];
  char* tmp = "01-01-1900";
  int k = 0;
  while (n < 365) {
    char* date = days_to_date(n, year);
    if (strncmp(date, tmp, 2) != 0) {
      last_fridays[k] = tmp;
      k++;
    }
    n += 7;
    tmp = date;
  }
  last_fridays[k] = tmp;
  for (int i = 0; i < 12; i++)
    printf("%s\n", last_fridays[i]);
}

int main() {
  fridays(2024);
}
