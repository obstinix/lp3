#include <algorithm>
#include <chrono>
#include <iostream>
#include <random>
#include <vector>

using namespace std;

int deterministicPartition(vector<int>& arr, int low, int high) {
    int pivot = arr[high];
    int i = low - 1;

    for (int j = low; j < high; ++j) {
        if (arr[j] <= pivot) {
            ++i;
            swap(arr[i], arr[j]);
        }
    }

    swap(arr[i + 1], arr[high]);
    return i + 1;
}

void deterministicQuickSort(vector<int>& arr, int low, int high) {
    if (low < high) {
        int pivotIndex = deterministicPartition(arr, low, high);
        deterministicQuickSort(arr, low, pivotIndex - 1);
        deterministicQuickSort(arr, pivotIndex + 1, high);
    }
}

int randomizedPartition(
    vector<int>& arr,
    int low,
    int high,
    mt19937& generator
) {
    uniform_int_distribution<int> distribution(low, high);
    int randomIndex = distribution(generator);
    swap(arr[randomIndex], arr[high]);
    return deterministicPartition(arr, low, high);
}

void randomizedQuickSort(
    vector<int>& arr,
    int low,
    int high,
    mt19937& generator
) {
    if (low < high) {
        int pivotIndex = randomizedPartition(arr, low, high, generator);
        randomizedQuickSort(arr, low, pivotIndex - 1, generator);
        randomizedQuickSort(arr, pivotIndex + 1, high, generator);
    }
}

void printArray(const string& label, const vector<int>& arr) {
    cout << label;
    for (int value : arr) {
        cout << value << ' ';
    }
    cout << '\n';
}

int main() {
    int n;
    cout << "Enter the number of elements for the array: ";
    if (!(cin >> n) || n < 0) {
        cerr << "Please enter a non-negative integer.\n";
        return 1;
    }

    random_device device;
    mt19937 generator(device());
    uniform_int_distribution<int> valueDistribution(1, 100000);
    vector<int> original(n);
    for (int& value : original) {
        value = valueDistribution(generator);
    }

    vector<int> deterministic = original;
    auto deterministicStart = chrono::high_resolution_clock::now();
    deterministicQuickSort(deterministic, 0, n - 1);
    auto deterministicEnd = chrono::high_resolution_clock::now();

    vector<int> randomized = original;
    auto randomizedStart = chrono::high_resolution_clock::now();
    randomizedQuickSort(randomized, 0, n - 1, generator);
    auto randomizedEnd = chrono::high_resolution_clock::now();

    printArray("\nOriginal array: ", original);
    printArray("\nDeterministic sorted array: ", deterministic);
    printArray("Randomized sorted array: ", randomized);

    chrono::duration<double> deterministicTime =
        deterministicEnd - deterministicStart;
    chrono::duration<double> randomizedTime =
        randomizedEnd - randomizedStart;
    cout << "Deterministic time: " << deterministicTime.count() << "s\n";
    cout << "Randomized time: " << randomizedTime.count() << "s\n";

    return 0;
}
