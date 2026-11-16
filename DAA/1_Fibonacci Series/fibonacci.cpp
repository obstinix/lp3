#include <iostream>
#include <vector>
using namespace std;

long long recursiveFibonacci(int n, long long& callCount) {
    ++callCount;
    if (n <= 1) {
        return n;
    }
    return recursiveFibonacci(n - 1, callCount)
         + recursiveFibonacci(n - 2, callCount);
}

vector<long long> iterativeSeries(int n) {
    vector<long long> series;
    for (int i = 0; i < n; ++i) {
        if (i == 0) {
            series.push_back(0);
        } else if (i == 1) {
            series.push_back(1);
        } else {
            series.push_back(series[i - 1] + series[i - 2]);
        }
    }
    return series;
}

vector<long long> recursiveSeries(int n, long long& callCount) {
    vector<long long> series;
    for (int i = 0; i < n; ++i) {
        series.push_back(recursiveFibonacci(i, callCount));
    }
    return series;
}

void printSeries(const string& label, const vector<long long>& series) {
    cout << label;
    for (long long value : series) {
        cout << value << ' ';
    }
    cout << '\n';
}

int main() {
    int n;
    cout << "Enter the number of Fibonacci terms: ";
    if (!(cin >> n) || n < 0) {
        cerr << "The number of terms must be a non-negative integer.\n";
        return 1;
    }

    vector<long long> iterative = iterativeSeries(n);
    long long recursiveCallCount = 0;
    vector<long long> recursive = recursiveSeries(n, recursiveCallCount);

    printSeries("Iterative series: ", iterative);
    printSeries("Recursive series: ", recursive);
    cout << "Recursive function calls: " << recursiveCallCount << '\n';
    cout << "Iterative time complexity: O(n)\n";
    cout << "Iterative space complexity: O(n)\n";
    cout << "Recursive time complexity: O(2^n) commonly\n";
    cout << "Recursive space complexity: O(n)\n";

    return 0;
}
