#include <bits/stdc++.h>
using namespace std;

std::map<string, string> translator = {
	{"0000", "0"},
	{"0001", "1"},
	{"0010", "2"},
	{"0011", "3"},
	{"0100", "4"},
	{"0101", "5"},
	{"0110", "6"},
	{"0111", "7"},
	{"1000", "8"},	
	{"1001", "9"},
	{"1010", "A"},
	{"1011", "B"},
	{"1100", "C"},
	{"1101", "D"},
	{"1110", "E"},
	{"1111", "F"}
};

int main(void) {
	
	int count = 0;
	while (true) {
		string origin;
		std::cin >> origin;
		if (origin == "" || origin == "\n") {
			break;
		}
		else {
			if (count == 0) std::cout << "0x";
			std::cout << translator[origin];
		}
		if (count == 7) {
			std::cout << endl;
			count = 0;
		} else {
			count++;
		}
	}
	return 0;
}