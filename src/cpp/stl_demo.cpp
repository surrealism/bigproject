#include <iostream>
#include <vector>
#include <map>
#include <set>
#include <algorithm>
#include <string>

void demo_vector() {
    std::vector<int> nums = {5, 3, 1, 4, 2};
    std::sort(nums.begin(), nums.end());
    std::cout << "[vector] sorted: ";
    for (int n : nums) std::cout << n << " ";
    std::cout << "\n";

    nums.push_back(6);
    std::cout << "[vector] after push_back: ";
    for (int n : nums) std::cout << n << " ";
    std::cout << "\n";
}

void demo_map() {
    std::map<std::string, int> ages;
    ages["Alice"] = 30;
    ages["Bob"] = 25;
    ages["Charlie"] = 35;

    std::cout << "[map] entries:\n";
    for (const auto& [name, age] : ages) {
        std::cout << "  " << name << " -> " << age << "\n";
    }
}

void demo_set() {
    std::set<int> s = {3, 1, 4, 1, 5, 9, 2, 6};
    std::cout << "[set] unique sorted: ";
    for (int n : s) std::cout << n << " ";
    std::cout << "\n";

    auto it = s.find(4);
    if (it != s.end()) std::cout << "[set] found: " << *it << "\n";
}

void demo_algorithm() {
    std::vector<int> v = {10, 20, 30, 40, 50};
    auto it = std::find_if(v.begin(), v.end(), [](int x) { return x > 25; });
    if (it != v.end()) std::cout << "[algorithm] first > 25: " << *it << "\n";

    int sum = 0;
    std::for_each(v.begin(), v.end(), [&sum](int x) { sum += x; });
    std::cout << "[algorithm] sum: " << sum << "\n";
}

int main() {
    demo_vector();
    demo_map();
    demo_set();
    demo_algorithm();
    return 0;
}
