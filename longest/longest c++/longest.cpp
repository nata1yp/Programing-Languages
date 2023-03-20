// C++ implementation of above approach
#include <bits/stdc++.h>
using namespace std;
 
// Utility Function to find the index
// with maximum difference
int maxIndexDiff(int arr[], int m)
{
    int maxDiff;
    int i, j;
 
    int LMin[m], RMax[m];
 
    // Construct LMin[] such that LMin[i]
    // stores the minimum value
    // from (arr[0], arr[1], ... arr[i])
    LMin[0] = arr[0];
    for (i = 1; i < m; ++i)
        LMin[i] = min(arr[i], LMin[i - 1]);
 
    // Construct RMax[] such that RMax[j]
    // stores the maximum value
    // from (arr[j], arr[j+1], ..arr[n-1])
    RMax[m - 1] = arr[m - 1];
    for (j = m - 2; j >= 0; --j)
        RMax[j] = max(arr[j], RMax[j + 1]);
 
    // Traverse both arrays from left to right
    // to find optimum j - i
    // This process is similar to merge()
    // of MergeSort
    i = 0, j = 0, maxDiff = -1;
    while (j < m && i < m) {
        if (LMin[i] < RMax[j]) {
            maxDiff = max(maxDiff, j - i);
            j = j + 1;
        }
        else
            i = i + 1;
    }
 
    return maxDiff + 1;
}
 
// utility Function which subtracts X from all
// the elements in the array
void modifyarr(int arr[], int m, int n)
{
    for (int i = 0; i < m; i++)
        arr[i] = -arr[i] - n;
}
 
// Calculating the prefix sum array
// of the modified array
void calcprefix(int arr[], int m)
{
    int s = 0;
    for (int i = 0; i < m; i++) {
        s += arr[i];
        arr[i] = s;
    }
}
 
// Function to find the length of the longest
// subarray with average >= x
int longestsubarray(int arr[], int m, int n)
{
    modifyarr(arr, m, n);
    calcprefix(arr, m);
 
    return maxIndexDiff(arr, m);
}
 
// Driver code
int main(int argc, char **argv)
{
    ifstream infile(argv[1]);
    int m, n, i;
    infile >> m >> n;
    int d[m];
    for (i=0; i<m; i++){
        infile >> d[i];
    }
    int r=longestsubarray(d, m, n);
    if (r == m)
        cout << r << endl;
    else 
        cout << r-1 << endl;
 
    return 0;
}