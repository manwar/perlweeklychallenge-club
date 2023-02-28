/*
Challenge 206

Task 1: Shortest Time
Submitted by: Mohammad S Anwar

You are given a list of time points, at least 2, in the 24-hour clock format HH:MM.

Write a script to find out the shortest time in minutes between any two time points.
Example 1

Input: @time = ("00:00", "23:55", "20:00")
Output: 5

Since the difference between "00:00" and "23:55" is the shortest (5 minutes).

Example 2

Input: @array = ("01:01", "00:50", "00:57")
Output: 4

Example 3

Input: @array = ("10:10", "09:30", "09:00", "09:55")
Output: 15
*/

#include <algorithm>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

int minutes(const std::string& str) {
	int hours = 0, minutes = 0;
	char sep;
	std::istringstream iss{ str };
	if ((iss >> hours >> sep >> minutes) && sep == ':')
		return hours * 60 + minutes;
	else
		return 0;
}

int main(int argc, char* argv[]) {
	argv++; argc--;
	if (argc < 2) {
		std::cerr << "Usage: ch-1 time..." << std::endl;
		return EXIT_FAILURE;
	}

	std::vector<int> items;
	for (int i = 0; i < argc; i++)
		items.push_back(minutes(argv[i]));
	std::sort(items.begin(), items.end());
	items.push_back(items.front() + 24 * 60);

	int min = items.back() - items.front();
	for (size_t i = 0; i < items.size() - 1; i++) {
		for (size_t j = i + 1; j < items.size(); j++) {
			int n = items[j] - items[i];
			if (n < min)
				min = n;
		}
	}

	std::cout << min << std::endl;

	return EXIT_SUCCESS;
}
