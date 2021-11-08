/*
Challenge 120

TASK #2 › Clock Angle
Submitted by: Mohammad S Anwar
You are given time $T in the format hh:mm.

Write a script to find the smaller angle formed by the hands of an analog
clock at a given time.

HINT: A analog clock is divided up into 12 sectors. One sector represents 30
degree (360/12 = 30).

Example
Input: $T = '03:10'
Output: 35 degree

The distance between the 2 and the 3 on the clock is 30 degree.
For the 10 minutes i.e. 1/6 of an hour that have passed.
The hour hand has also moved 1/6 of the distance between the 3 and the 4,
which adds 5 degree (1/6 of 30).
The total measure of the angle is 35 degree.

Input: $T = '04:00'
Output: 120 degree
*/

#include <iostream>
#include <sstream>
#include <string>
using namespace std;

bool parse_time(const string& hhmm, int* hh, int* mm) {
    *hh = *mm = 0;
    istringstream iss(hhmm);
    char c;
    if (!(iss >> *hh)) return false;
    if (!(iss >> c) || c != ':') return false;
    if (!(iss >> *mm)) return false;
    return true;
}

int clock_angle(int hh, int mm) {
    int mm_angle = mm*360/60;
    int hh_angle = (hh % 12)*360/12 + mm_angle/12;
    int angle = abs(hh_angle - mm_angle);
    if (angle > 180) { angle = 360 - angle; }
    return angle;
}

int main(int argc, char* argv[]) {
    if (argc != 2) return EXIT_FAILURE;
    int hh, mm;
    if (!parse_time(argv[1], &hh, &mm)) return EXIT_FAILURE;
    int angle = clock_angle(hh, mm);
    cout << angle << endl;
}
