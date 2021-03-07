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

#include <iostream>
#include <iomanip>
#include <sstream>
#include <cctype>

class Time {
public:
    Time(int hours = 0, int minutes = 0)
        : m_hours(hours), m_minutes(minutes), m_is12(false) {}

    int hours() const { return m_hours; }
    int minutes() const { return m_minutes; }
    bool is12() const { return m_is12; }
    void set12() { m_is12 = true; }
    void set24() { m_is12 = false; }

    friend std::ostream& operator<<(std::ostream& os, const Time& time);
    friend std::istream& operator>>(std::istream& is, Time& time);

private:
    int m_hours, m_minutes; // always in 24 hour format
    bool m_is12;
};

std::ostream& operator<<(std::ostream& os, const Time& time) {
    if (time.m_is12) {
        int hours = time.m_hours;
        bool ispm = false;
        if (hours == 0)
            hours = 12;
        else if (hours == 12)
            ispm = true;
        else if (hours > 12) {
            ispm = true;
            hours -= 12;
        }
        os << std::setw(2) << std::setfill('0') << hours << ":"
            << std::setw(2) << std::setfill('0') << time.m_minutes
            << (ispm ? "pm" : "am");
    }
    else
        os << std::setw(2) << std::setfill('0') << time.m_hours << ":"
        << std::setw(2) << std::setfill('0') << time.m_minutes;
    return os;
}

std::istream& operator>>(std::istream& is, Time& time) {
    // get hh:mm
    char colon = '\0';
    if (!(is >> time.m_hours >> colon >> time.m_minutes) || colon != ':') {
        std::cerr << "error parsing time" << std::endl;
        exit(EXIT_FAILURE);
    }

    // get optional am|pm
    std::string ampm;
    is >> ampm;

    // convert from 12 to 24 format
    if (!ampm.empty()) {
        switch (tolower(ampm[0])) {
        case 'a':
            if (time.m_hours == 12) time.m_hours = 0;
            time.m_is12 = true;
            break;
        case 'p':
            if (time.m_hours != 12) time.m_hours += 12;
            time.m_is12 = true;
            break;
        default:
            std::cerr << "error parsing time" << std::endl;
            exit(EXIT_FAILURE);
        }
    }
    return is;
}


int main(int argc, char* argv[]) {
    if (argc != 2) {
        fputs("Usage: ch-1 time", stderr);
        return EXIT_FAILURE;
    }

    Time time;
    std::stringstream ss(argv[1]);
    ss >> time;
    if (time.is12())
        time.set24();
    else
        time.set12();
    std::cout << time << std::endl;
}
