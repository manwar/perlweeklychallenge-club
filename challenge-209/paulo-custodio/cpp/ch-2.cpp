/*
Challenge 209

Task 2: Merge Account
Submitted by: Mohammad S Anwar

You are given an array of accounts i.e. name with list of email addresses.

Write a script to merge the accounts where possible. The accounts can only
be merged if they have at least one email address in common.

Example 1:

Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
                     ["B", "b1@b.com"],
                     ["A", "a3@a.com", "a1@a.com"] ]
                   ]

Output: [ ["A", "a1@a.com", "a2@a.com", "a3@a.com"],
          ["B", "b1@b.com"] ]

Example 2:

Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
                     ["B", "b1@b.com"],
                     ["A", "a3@a.com"],
                     ["B", "b2@b.com", "b1@b.com"] ]

Output: [ ["A", "a1@a.com", "a2@a.com"],
          ["A", "a3@a.com"],
          ["B", "b1@b.com", "b2@b.com"] ]
*/

#include <algorithm>
#include <iostream>
#include <string>
#include <vector>

struct Account {
    std::string name;
    std::vector<std::string> emails;

    Account(const std::string& name_) : name(name_) {}

    void merge(const Account& other) {
        emails.insert(emails.end(), other.emails.begin(), other.emails.end());  // concatenate
        std::sort(emails.begin(), emails.end());                                // sort
        auto it = std::unique(emails.begin(), emails.end());                    // uniq
        emails.resize(std::distance(emails.begin(), it));
    }
};

bool find_common(std::vector<Account>& accs, size_t& a, size_t& b) {
    for (a = 0; a < accs.size() - 1; a++) {
        for (size_t i = 0; i < accs[a].emails.size(); i++) {
            std::string& email = accs[a].emails[i];
            for (b = a + 1; b < accs.size(); b++) {
                auto it = std::find(accs[b].emails.begin(), accs[b].emails.end(), email);
                if (it != accs[b].emails.end())
                    return true;
            }
        }
    }
    return false;
}

void merge_accounts(std::vector<Account>& accs) {
    size_t a, b;
    while (find_common(accs, a, b)) {
        accs[a].merge(accs[b]);
        accs.erase(accs.begin() + b);
    }
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc == 0) {
        std::cerr << "usage: ch-2 name emails... name emails..." << std::endl;
        return EXIT_FAILURE;
    }

    std::vector<Account> accs;

    for (int i = 0; i < argc; i++) {
        std::string name = argv[i++];
        accs.emplace_back(name);
        for (; i < argc && std::string(argv[i])!= ","; i++) {
            std::string email = argv[i];
            accs.back().emails.push_back(email);
        }
    }

    merge_accounts(accs);

    for (size_t i = 0; i < accs.size(); i++) {
        std::cout << accs[i].name << " ";
        for (size_t j = 0; j < accs[i].emails.size(); j++)
            std::cout << accs[i].emails[j] << " ";
        std::cout << std::endl;
    }
}
