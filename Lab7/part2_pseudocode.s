# LIST[0] = n (number of items)
# LIST[1..n] = numbers to be sorted in place

n = LIST[0]
base = &LIST[1]   # pointer to the first actual number

# Outer loop: n - 1 passes
for i in range(0, n - 1):

    # Inner loop: each time, we go from the start up to (n - 1 - i)
    # because the largest elements "bubble up" to the right
    for j in range(0, n - 1 - i):

        # addr points to element j (base + j)
        addr = base + j

        # SWAP gets passed the address of LIST[j]
        # It compares LIST[j] and LIST[j+1], and swaps them
        # if LIST[j] > LIST[j+1].
        swapped = SWAP(addr)

        # We don't *need* swapped for correctness if we always do
        # all passes. (We could use it to early-stop if no swaps.)



------------------------------------------
void bubbleSort(vector<int>& arr) {
    int n = arr.size();
    bool swapped;
  
    for (int i = 0; i < n - 1; i++) {
        swapped = false;
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                swap(arr[j], arr[j + 1]);
                swapped = true;
            }
        }
      
        // If no two elements were swapped, then break
        if (!swapped)
            break;
    }
}