#include <iostream>

class fillable_string: public std::string {
public:
  void fill_digits();
};

void fillable_string::fill_digits() {
  auto s = this->data();
  char fill_char = ' ';
  for (int i=0; i < this->size(); i++) {
    if (std::isdigit(s[i])) {
      s[i] += fill_char - '0'; // to shift the char val
    } else {
      fill_char = s[i];
    }
  }
}

int main() {
  fillable_string inputs[]{
    {"a1c1e1"},
    {"a1b2c3d4"},
    {"b2b"},
    {"a16z"}
  };
  for (int i=0; i < 4; i++) {
    std::cout << inputs[i] << " => ";
    inputs[i].fill_digits();
    std::cout << inputs[i] << '\n';
  }
}
