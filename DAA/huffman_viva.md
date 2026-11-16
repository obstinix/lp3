# Huffman Encoding - DAA Viva Preparation

## Program Objective

Construct a Huffman tree from characters and their frequencies, then generate
a binary code for every character. Huffman coding is a lossless compression
technique based on a greedy algorithm.

The program accepts a character and its positive frequency for each symbol,
builds the tree using a min-heap, and prints the resulting Huffman codes.

## Top 20 Viva Questions and Answers

### 1. What is Huffman encoding?

Huffman encoding is a lossless data-compression technique. It assigns shorter
binary codes to frequent characters and longer codes to less frequent
characters.

### 2. Why is Huffman coding called lossless?

It is lossless because the original data can be reconstructed exactly from
the encoded data. No information is discarded.

### 3. What is the main idea of Huffman coding?

Repeatedly combine the two nodes with the smallest frequencies. The combined
node becomes their parent, whose frequency is the sum of the two child
frequencies. Continue until one root node remains.

### 4. Which algorithmic design technique does Huffman coding use?

It uses the **greedy method**. At every step, it makes the locally optimal
choice of combining the two least frequent nodes.

### 5. What is a Huffman tree?

A Huffman tree is a binary tree used to represent the codes. Moving left
represents bit `0`, and moving right represents bit `1`. A character is stored
at each leaf.

### 6. How are codes generated in this program?

The `generateCodes` function traverses the tree recursively:

- Append `"0"` when moving to the left child.
- Append `"1"` when moving to the right child.
- Store the accumulated string when a leaf is reached.

### 7. What is a prefix code?

A prefix code is a code in which no character's code is the prefix of another
character's code. Huffman codes are prefix-free, so decoding is unambiguous.

### 8. Why are characters stored only at leaf nodes?

Storing characters only at leaves guarantees the prefix-free property. An
internal node represents a combined frequency, not an actual input character.

### 9. Why is a min-heap used?

A min-heap quickly provides the two nodes with the smallest frequencies,
which are required at every greedy step.

### 10. What is the role of `priority_queue` in the program?

The C++ `priority_queue` is used as the heap. Since it is a max-heap by
default, the custom `Compare` comparator reverses the order so that the
smallest frequency appears at the top.

### 11. What does the comparator do?

The comparator returns:

```cpp
return a->freq > b->freq;
```

This makes the node with the lower frequency have higher priority in the
priority queue.

### 12. Why are the two smallest nodes combined first?

The two least frequent symbols should be placed deepest in the tree. Combining
them first is the greedy choice that leads to an optimal prefix-code tree.

### 13. What is the time complexity of building the Huffman tree?

For `n` distinct characters, the tree is built in `O(n log n)` time. There are
`n - 1` combine operations, and each heap insertion or removal costs
`O(log n)`.

### 14. What is the time complexity of generating the codes?

The tree traversal visits every tree node once. Therefore, code generation
takes `O(n)` time for `n` characters.

### 15. What is the overall time complexity?

The heap construction dominates the traversal:

```text
O(n log n) + O(n) = O(n log n)
```

### 16. What is the space complexity?

The tree, heap, character set, and code map require `O(n)` space. The
recursion stack used during tree traversal is also at most `O(n)`.

### 17. How is the average code length calculated?

If character `i` has frequency `f_i` and code length `l_i`, the weighted
average code length is:

```text
sum(f_i * l_i) / sum(f_i)
```

Huffman coding minimizes this weighted average among binary prefix codes.

### 18. What is the purpose of the `Node` structure?

Each `Node` stores:

- `ch`: the character for a leaf node.
- `freq`: the character frequency or combined frequency.
- `left` and `right`: pointers to child nodes.

Internal nodes use `$` as a placeholder character because they do not
represent input characters.

### 19. What happens when there is only one character?

The tree contains one leaf and its path is empty. The program assigns it code
`0` so that the output still contains a valid non-empty binary code.

### 20. Why does the program reject duplicate characters and invalid frequencies?

Each character must represent one unique symbol in the frequency table.
Frequencies must be positive because zero or negative values do not represent
valid symbol probabilities for Huffman coding.

## Additional Relevant Questions

### 21. Does this program encode an actual input message?

No. It constructs and prints the Huffman code table. A complete compression
program would also replace each input character with its code and provide a
decoder.

### 22. How is a Huffman-encoded message decoded?

Start at the root and read one bit at a time. Move left for `0` and right for
`1`. Whenever a leaf is reached, output its character and return to the root.

### 23. Why can two correct Huffman code tables look different?

If two nodes have equal frequencies, either one may be selected first.
Swapping left and right branches also changes the bit strings. The resulting
codes may differ while having the same total weighted cost.

### 24. Why is `map` used for the output code table?

`map` stores entries in sorted key order, making the displayed output
deterministic. The Huffman tree itself is still determined by frequencies and
tie choices.

### 25. What is the difference between fixed-length and variable-length coding?

Fixed-length coding assigns the same number of bits to every symbol.
Huffman coding uses variable-length codes, assigning fewer bits to more
frequent symbols.

### 26. What is the greedy-choice property in Huffman coding?

The two least frequent symbols can be placed as sibling leaves at the deepest
level of an optimal tree. Combining them into one composite node preserves the
possibility of constructing an optimal solution.

### 27. What is the optimal-substructure property?

After combining the two least frequent nodes, the remaining problem is a
smaller Huffman problem involving the combined node. An optimal solution to
the smaller problem leads to an optimal solution to the original problem.

### 28. What is the purpose of `deleteTree`?

Nodes are allocated dynamically using `new`. `deleteTree` recursively deletes
the left and right subtrees and then deletes each node, preventing memory
leaks.

### 29. What is the difference between Huffman coding and encryption?

Huffman coding compresses data; it does not provide secrecy. Anyone with the
code table can decode the data, so encryption is needed when confidentiality
is required.

### 30. What happens if the input contains zero characters?

The program rejects it because constructing a Huffman tree requires at least
one character. It prints an error instead of calling `top()` on an empty
heap.

## Example

For the frequencies below:

```text
a 5
b 9
c 12
d 13
```

The program may produce:

```text
a : 00
b : 01
c : 10
d : 11
```

The exact bit patterns can change when frequencies tie, but the code remains
prefix-free and the weighted cost remains optimal.

## Quick Exam Revision

- Huffman coding is lossless.
- It uses a greedy strategy.
- Always combine the two least frequent nodes.
- A min-heap supports efficient selection.
- Left edge = `0`; right edge = `1`.
- Characters are stored at leaf nodes.
- Huffman codes are prefix-free.
- Tree construction: `O(n log n)`.
- Code generation: `O(n)`.
- Overall time: `O(n log n)`.
- Space complexity: `O(n)`.
- The program prints codes but does not encode or decode a message.
- Equal frequencies may produce different but equally optimal code tables.
