/*
Challenge 101

TASK #1 › Pack a Spiral
Submitted by: Stuart Little

You are given an array @A of items (integers say, but they can be anything).

Your task is to pack that array into an MxN matrix spirally counterclockwise, 
as tightly as possible.

‘Tightly’ means the absolute value |M-N| of the difference has to be as small 
as possible.
*/

#include <iostream>
#include <iomanip>
#include <vector>

int numbers_width;

std::vector<int> collect_numbers(int argc, char* argv[]) {
	std::vector<int> numbers;
    for (int i = 0; i < argc; i++) {
        numbers.push_back(atoi(argv[i]));
        if (numbers[i] >= 1000 && numbers_width < 4) numbers_width = 4;
        else if (numbers[i] >= 100 && numbers_width < 3) numbers_width = 3;
        else if (numbers[i] >= 10 && numbers_width < 2) numbers_width = 2;
        else if (numbers_width < 1) numbers_width = 1;
    }
    return numbers;
}

void smallest_rect(int n, int& width, int& height) {
    width = 1; height = n;
    for (int i = 1; i <= n; i++) {
        if ((n % i) == 0) {
            width = i; height = n / i;
            if (width >= height)
                break;
        }
    }
}

std::vector<std::vector<int>> make_empty_rect(int width, int height) {
	std::vector<std::vector<int>> rect;
    for (int r = 0; r < height; r++) {
		rect.push_back({});
        for (int c = 0; c < width; c++)
            rect[r].push_back(-1);
    }
    return rect;
}

void fill_spiral(std::vector<std::vector<int>>& rect, 
			     std::vector<int>& numbers) {
	int width  = static_cast<int>(rect[0].size());
	int height = static_cast<int>(rect.size());
	int count  = static_cast<int>(numbers.size());
    int i = 0;
    int r = height - 1;
    int c = 0;
    while (i < count) {
        // go East
        while (c < width && rect[r][c] < 0) {
            rect[r][c] = numbers[i++];
            c++;
        }
        c--; r--;

        // go North
        while (r >= 0 && rect[r][c] < 0) {
            rect[r][c] = numbers[i++];
            r--;
        }
        r++; c--;

        // go West
        while (c >= 0 && rect[r][c] < 0) {
            rect[r][c] = numbers[i++];
            c--;
        }
        c++; r++;

        // go South
        while (r < height && rect[r][c] < 0) {
            rect[r][c] = numbers[i++];
            r++;
        }
        r--; c++;
    }
}

void print_spiral(std::vector<std::vector<int>>& rect) {
	int width  = static_cast<int>(rect[0].size());
	int height = static_cast<int>(rect.size());
    for (int r = 0; r < height; r++) {
        for (int c = 0; c < width; c++)
            std::cout << std::setw(numbers_width + 1) << rect[r][c];
        std::cout << std::endl;
    }
}

void spiral(int count, char* nums[]) {
    std::vector<int> numbers = collect_numbers(count, nums);
    int height, width;
    smallest_rect(count, width, height);
    std::vector<std::vector<int>> rect = make_empty_rect(width, height);
    fill_spiral(rect, numbers);
    print_spiral(rect);
}

int main(int argc, char* argv[]) {
    if (argc == 1) {
        std::cerr << "Usage: ch-1 N..." << std::endl;
        exit(EXIT_FAILURE);
    }
    else 
        spiral(--argc, ++argv);
}
