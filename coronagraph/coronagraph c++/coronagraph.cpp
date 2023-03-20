#include<bits/stdc++.h>
#include <iostream>
#include <vector> 
#include<stdlib.h> 
#include<stdio.h> 
#include <fstream>

using namespace std;

vector<int> adj[10000000];
vector<int> cycle;
vector<int> nodes;


void addEdge(vector<int> adj[], char visited[], int u, int v) 
{ 
    adj[u].push_back(v); 
    adj[v].push_back(u); 
    visited[v] = 0;
    visited[u] = 0;
} 
  


void dfs(vector<int> adj[], char visited[], int v, int &count, int left, int right)
{
    visited[v] = 1;
    count++;

    vector<int> :: iterator i;
    for (i = adj[v].begin(); i!=adj[v].end(); ++i)
    {
        if (!visited[*i])
        {
            dfs(adj, visited,*i, count, left, right);
                
        }
        
    }
}
    


bool find_cycle(vector<int> adj[], char unvisited[], vector<int> &cycle, int v, int parent, int &x)
{

    unvisited[v] = 0;
    
    vector<int> :: iterator i;
    for (i = adj[v].begin(); i!=adj[v].end(); ++i)
    {
        if (unvisited[*i])
        {
            if (find_cycle(adj, unvisited, cycle, *i, v, x)){
            cycle.push_back(*i);
            return true;}
            
        }
        else
        {
            if (*i!=parent){
            x=*i;
            return true;}
        }
    }

    return false;
    
 }

bool is_cyclic(vector<int> adj[], char visited[], int v, int parent, int left, int right, int &count)
{
    visited[v] = 1;
    count++;
    
    vector<int> :: iterator i;
    for (i = adj[v].begin(); i!=adj[v].end(); ++i)
    {
        if (!visited[*i])
        {
            if (is_cyclic(adj, visited,*i, v, left, right, count))
                return true;
                
        }
        else if (*i!=parent && *i!=left && *i!=right)
            return true;
        
    }
    
    return false;
}

void merge(vector<int> &arr, int l, int m, int r) 
{ 
    int i, j, k; 
    int n1 = m - l + 1; 
    int n2 =  r - m; 
  
    /* create temp arrays */
    int L[n1], R[n2]; 
  
    /* Copy data to temp arrays L[] and R[] */
    for (i = 0; i < n1; i++) 
        L[i] = arr[l + i]; 
    for (j = 0; j < n2; j++) 
        R[j] = arr[m + 1+ j]; 
  
    /* Merge the temp arrays back into arr[l..r]*/
    i = 0; // Initial index of first subarray 
    j = 0; // Initial index of second subarray 
    k = l; // Initial index of merged subarray 
    while (i < n1 && j < n2) 
    { 
        if (L[i] <= R[j]) 
        { 
            arr[k] = L[i]; 
            i++; 
        } 
        else
        { 
            arr[k] = R[j]; 
            j++; 
        } 
        k++; 
    } 
  
    /* Copy the remaining elements of L[], if there 
       are any */
    while (i < n1) 
    { 
        arr[k] = L[i]; 
        i++; 
        k++; 
    } 
  
    /* Copy the remaining elements of R[], if there 
       are any */
    while (j < n2) 
    { 
        arr[k] = R[j]; 
        j++; 
        k++; 
    } 
} 
  
/* l is for left index and r is right index of the 
   sub-array of arr to be sorted */
void mergeSort(vector<int> &arr, int l, int r) 
{ 
    if (l < r) 
    { 
        // Same as (l+r)/2, but avoids overflow for 
        // large l and h 
        int m = l+(r-l)/2; 
  
        // Sort first and second halves 
        mergeSort(arr, l, m); 
        mergeSort(arr, m+1, r); 
  
        merge(arr, l, m, r); 
    } 
} 


// Driver code 
int main(int argc, char **argv) 
{ 	
    int V, T, M;
    int a, b;
    ifstream infile;
    infile.open(argv[1]);
    infile >> T;
    for (int i=0; i<T; i++)
    {
        int flag=1;
        infile >> V;
        infile >> M;
        //vector<int> adj[V];
        char visited[V];
        for (int j=0; j<M; j++)
        {
            infile >> a;
            infile >> b;
            addEdge(adj, visited, a-1, b-1);
            
        }
    
    
    //vector<int> cycle;
    //vector<int> nodes;
     	
    bool y=false;
    bool cyclic = false;
    
    int counter = 0;
    int x=-1;
   	
    int start=0;
    
    	
   
 	dfs(adj, visited, start, counter, -1, -1);
    if (counter!=V)
        cout << "NO CORONA\n";
    else
    {
        y=find_cycle(adj, visited, cycle, start, -1, x);
        if (!y) cout << "NO CORONA\n";
        else
        {
            if (x == start)
            cycle.push_back(x);
            int n = cycle.size();
            if (n!=0)
            while (cycle[n-1]!=x)
            {
                cycle.pop_back();
                n--;
            }
            n = cycle.size();
            for (int i=0; i<V; i++)
                visited[i] = 0;
            for (int i=0; i<n; i++)
            {	
                
                int elem = cycle[i];
                visited[elem] = 1;
            }
        
    
            
            for (int i=0; i<n; i++)
            {
                counter=0;
                if (i==0)
                {	cyclic = is_cyclic(adj, visited, cycle[i], -1, cycle[n-1], cycle[i+1], counter);
                    
                }
                else if (i==n-1)
                {
                    cyclic = is_cyclic(adj, visited, cycle[i], -1, cycle[i-1], cycle[0], counter);
                    
                }
                else 
                {
                    cyclic = is_cyclic(adj, visited, cycle[i], -1, cycle[i-1], cycle[i+1], counter);
                    
                }
                if (cyclic) 
                {
                    cout << "NO CORONA\n";
                    flag = 0;
                    break;
                }
                nodes.push_back(counter);
                
            }
            
    			
            if (flag)
            {
                mergeSort(nodes, 0, n-1); 
  		
                cout << "CORONA " << n << "\n";
                for (int i=0; i<n; i++)
                {
                    if (i!=n-1)
                        cout << nodes[i] << " ";
                    else cout << nodes[i];
                }
                cout << "\n";
            
            }



        }
    }
		for (int i = 0; i<V; i++) adj[i].clear();
		
		cycle.clear();
	
		nodes.clear();
    }
    infile.close();

    return 0; 
} 
 
