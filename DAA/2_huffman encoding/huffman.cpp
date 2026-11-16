#include <iostream>
#include <map>
#include <queue>
#include <set>
#include <string>
#include <vector>
using namespace std;

// Node of Huffman Tree
struct Node {
char ch;
long long freq;
Node *left, *right;
Node(char c, long long f) {
ch = c;
freq = f;
left = right = nullptr;
}
};

// Comparator for Min Heap
struct Compare {
bool operator()(Node* a, Node* b) {
return a->freq > b->freq;
}
};

void deleteTree(Node* root) {
if (root == nullptr)
return;
deleteTree(root->left);
deleteTree(root->right);
delete root;
}

// Generate Huffman Codes
void generateCodes(Node* root, string code,
map<char, string>& huffmanCode) {
if (root == nullptr)
return;

// Leaf node
if (root->left == nullptr && root->right == nullptr) {
huffmanCode[root->ch] = code.empty() ? "0" : code;
return;
}
generateCodes(root->left, code + "0", huffmanCode);
generateCodes(root->right, code + "1", huffmanCode);
}

int main() {
int n;
cout << "Enter number of characters: ";
if (!(cin >> n) || n <= 0) {
cerr << "Number of characters must be a positive integer.\n";
return 1;
}

priority_queue<Node*, vector<Node*>, Compare> minHeap;
set<char> characters;
cout << "Enter character and its frequency:\n";
for (int i = 0; i < n; i++) {
char ch;
long long freq;
cin >> ch >> freq;
if (!cin || freq <= 0) {
cerr << "Each character must have a positive frequency.\n";
while (!minHeap.empty()) {
delete minHeap.top();
minHeap.pop();
}
return 1;
}
if (!characters.insert(ch).second) {
cerr << "Duplicate characters are not allowed.\n";
while (!minHeap.empty()) {
delete minHeap.top();
minHeap.pop();
}
return 1;
}
minHeap.push(new Node(ch, freq));
}

// Build Huffman Tree
while (minHeap.size() > 1) {
Node* left = minHeap.top();
minHeap.pop();
Node* right = minHeap.top();
minHeap.pop();
Node* parent = new Node('$', left->freq + right->freq);

parent->left = left;
parent->right = right;
minHeap.push(parent);
}

Node* root = minHeap.top();
map<char, string> huffmanCode;
generateCodes(root, "", huffmanCode);
cout << "\nHuffman Codes:\n";
for (auto& pair : huffmanCode) {
cout << pair.first << " : " << pair.second << endl;
}

deleteTree(root);
return 0;
}