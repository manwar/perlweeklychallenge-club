#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
int base_year = 2000;
int days_in_month[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
char* days[7] = {"sat", "sun", "mon", "tue", "wed", "thu", "fri"};

bool is_leap_year(int year) {
  if (year % 400 == 0)
    return true;
  if (year % 100 == 0)
    return false;
  if (year % 4 == 0)
    return true;
  return false;
}

char* weekday(int year,int month,int day) {
  int skip_days = year - base_year;
  for (int yr = base_year; yr < year; yr++)
    if (is_leap_year(yr))
      skip_days++;
  if (is_leap_year(year) && month > 2)
    skip_days++;
  for (int m = 1; m < 13; m++)
    if (m < month)
      skip_days += days_in_month[m-1];
  skip_days += day - 1;
  return days[skip_days % 7];
}

bool is_weekend(int year,int month,int day) {
  char* today = weekday(year, month, day);
  if ((0 == strcmp(today, "sat")) || (0 == strcmp(today, "sun")))
    return true;
  return false;
}

char* format_date(int year,int month,int day) {
  char *buf = malloc(11*sizeof(char));
  char m[3];
  char d[3];
  sprintf(m, "%02d", month);
  sprintf(d, "%02d", day);
  sprintf(buf, "%d-%s-%s", year, m, d);
  return buf;
}

int* parse_date(char* date) {
  char y[5];
  char m[3];
  char d[3];
  for (int i = 0; i < 4; i++)
    y[i] = date[i];
  y[4] = '\0';
  for (int i = 0; i < 2; i++)
    m[i] = date[i+5];
  m[2] = '\0';
  for (int i = 0; i < 2; i++)
    d[i] = date[i+8];
  d[2] = '\0';
  
  int year = atoi(y);
  int month = atoi(m);
  int day = atoi(d);
  int* result = malloc(3*sizeof(int));
  result[0] = year;
  result[1] = month;
  result[2] = day;
  return result;
}

bool is_holiday(char* bank_holidays[], int bank_holidays_length, int year, int month, int day) {
  char* date = format_date(year, month, day);
  for (int i = 0; i < bank_holidays_length; i++)
    if (strcmp(bank_holidays[i], date) == 0) {
      free(date);
      return true;
    }
  free(date);      
  return false;
}

void proc(char* start_date, int offset, char* bank_holidays[], int bank_holidays_length) {
  int* result = parse_date(start_date);
  int year = result[0];
  int month = result[1];
  int day = result[2];
  free(result);
  int new_year = year;
  int new_month = month;
  int new_day = day;
  int steps = offset;
  while (steps > 0) {
    int leap = (is_leap_year(new_year) && new_month == 2) ? 1 : 0;
    if (new_day + 1 > leap + days_in_month[new_month - 1]) {
      if (new_month == 12)
	new_year++;
      new_month++;
      if (new_month == 13)
	new_month = 1;
      new_day = 1;
    } else
      new_day++;
    if ( (is_holiday(bank_holidays, bank_holidays_length, new_year, new_month, new_day) != 1) && (is_weekend(new_year, new_month, new_day) != 1)) steps--;
  }
    
  char* new_date = format_date(new_year, new_month, new_day);
  printf("Input: start: %s, offset: %d, holidays: ", start_date, offset);
  for (int i = 0; i < bank_holidays_length; i++)
    printf("%s ", bank_holidays[i]);
  printf("\nOutput: %s\n",new_date);
}

int main() {
  char* start_date = "2018-06-28";
  int offset = 3;
  char* bank_holiday1 = "2018-07-03";
  char* bank_holidays[] = {bank_holiday1};

  proc(start_date, offset, bank_holidays, 1);
}
