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

#include <iostream>
#include <fstream>
#include <string>
#include <memory>
#include <unordered_map>
#include <cstring>

// store list of open files
class Files {
public:
    Files() {}
    virtual ~Files() {
        for (auto& it : files)
            delete it.second;
    }

    std::string readN(const std::string filename, int n) {
        std::ifstream* ifs = add_file(filename);
        char* buffer = new char [n+1];
        memset(buffer, 0, n+1);
        ifs->read(buffer, n);
        auto text = std::string(buffer);
        delete[] buffer;
        return text;
    }

private:
    std::unordered_map<std::string, std::ifstream*> files;

    std::ifstream* add_file(const std::string filename) {
        auto found = files.find(filename);
        if (found != files.end())           // found in map
            return found->second;
        else {                              // not found, must create new entry
            auto ifs = new std::ifstream(filename);
            if (!ifs->is_open()) {
                std::cerr << "open file " << filename << " failed" << std::endl;
                exit(EXIT_FAILURE);
            }
            files.emplace(filename, ifs);
            return ifs;
        }
    }
};

int main(int argc, char* argv[]) {
    Files f;
    for (int i = 1; i+1 < argc; i+=2)
        std::cout << f.readN(argv[i], atoi(argv[i+1])) << std::endl;
}
