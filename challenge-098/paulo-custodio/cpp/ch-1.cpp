/*
Challenge 098

TASK #1 › Read N-characters
Submitted by: Mohammad S Anwar
You are given file $FILE.

Create subroutine readN($FILE, $number) returns the first n-characters and
moves the pointer to the (n+1)th character.

Example:
Input: Suppose the file (input.txt) contains "1234567890"
Output:
    print readN("input.txt", 4); # returns "1234"
    print readN("input.txt", 4); # returns "5678"
    print readN("input.txt", 4); # returns "90"
*/

#include <algorithm>
#include <array>
#include <iostream>
#include <fstream>
#include <string>
#include <cassert>
#include <cstring>

// store list of open files
class Files {
public:
    std::string readN(const std::string filename, int n) {
        std::ifstream& ifs = add_file(filename);
        char* buffer = new char[n + 1];
        memset(buffer, 0, n + 1);
        ifs.read(buffer, n);
        auto text = std::string(buffer);
        delete[] buffer;
        return text;
    }

private:
    // store std::ifstream in a pre-aloocated array as storing pointers to
    // std::ifstream in an unordered_map was causing a heap corruption in
    // GCC - probably a compiler/stdlib bug
    static const int MAX_FILES = 20;
    std::array<std::ifstream, MAX_FILES> files;
    std::array<std::string, MAX_FILES> filenames;
    size_t num_files{ 0 };

    std::ifstream& add_file(const std::string filename) {
        auto end = filenames.begin() + num_files;
        auto found = std::find(filenames.begin(), end, filename);
        if (found != end) {   // found in filename
            size_t i = std::distance(filenames.begin(), found);
            return files[i];
        }
        else {                                      // not found, must create new entry
            if (num_files >= MAX_FILES) {
                std::cerr << "too many files" << std::endl;
                exit(EXIT_FAILURE);
            }
            filenames[num_files] = filename;
            files[num_files].open(filename);
            if (!files[num_files].is_open()) {
                std::cerr << "open file " << filename << " failed" << std::endl;
                exit(EXIT_FAILURE);
            }
            return files[num_files++];
        }
    }
};

int main(int argc, char* argv[]) {
    Files f;
    for (int i = 1; i + 1 < argc; i += 2)
        std::cout << f.readN(argv[i], atoi(argv[i + 1])) << std::endl;
}
