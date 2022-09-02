#include<cstdio>
#include<vector>
#include<string>
#include<unordered_map>

char *first_unique_character(const std::string& str)
{
  char *buffer = new char[39]; 
  std::vector<char> chars{str.begin(), str.end()};
  std::unordered_map<char, unsigned> hash{};
  for(const char& c : str) hash[c]++;
  for(std::size_t i = 0; i < chars.size(); ++i)
    if(hash[chars[i]] == 1)
    {
      std::snprintf(buffer,
		    39,
		    "%zu as '%c' is the first unique character",
		    i,
		    chars[i]);
      break;
    }
  return buffer;
}

int main(int argc, char *argv[])
{
  if(argc < 2)
  {
    fprintf(stderr, "No arg(s) provided!");
    exit(1);
  }
  char *buffer = first_unique_character(argv[1]);
  printf("%s\n", buffer);
  delete buffer;
  
  return 0;
}
