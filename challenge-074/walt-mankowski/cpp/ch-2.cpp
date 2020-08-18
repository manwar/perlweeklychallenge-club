#include <string.h>
#include <iostream>
#include <set>
#include <list>

using namespace std;

int main(int argc, char *argv[]) {
    const char *s = argv[1];
    set<char> seen;
    list<char> nr;
    char *out = new char[strlen(s)+1];
    out[strlen(s)] = '\0';

    for (size_t i = 0; i < strlen(s); i++) {
        const char c = s[i];
        
        // have we seen c before?
        if (seen.find(c) == seen.end()) {
            seen.insert(c);
            nr.push_back(c);
        } else {
            // remove c from nr
            for (auto x = nr.begin(); x != nr.end(); x++)
                if (*x == c) {
                    nr.erase(x);
                    break;
                }
        }

        if (nr.empty()) 
            out[i] = '#';
        else {
            auto p = *(nr.crbegin());
            out[i] = p;
        }
    }
    cout << out << endl;                
}
