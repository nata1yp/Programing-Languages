#include <bits/stdc++.h>
//#include <iostream>
#include <stack>
using namespace std;

stack <int> si;
stack <int> sj;
int assoi(int** array, stack<int> &si, stack<int> &sj){
    while (!si.empty() && !sj.empty()) {
        int x, y;
        x = si.top();
        si.pop();
        y = sj.top();
        sj.pop();
        array[x][y] = 1;
    }
    return 0;
}

int zeros(int** array, stack<int> &si, stack<int> &sj){
    while (!si.empty() && !sj.empty()) {
        int x = si.top();
        si.pop();
        int y = sj.top();
        sj.pop();
        array[x][y] = 0;
    }
    return 0;
}

int mark(char** maze, int** array, int x, int y){

    si.push(x);
    sj.push(y);
    if (maze[x][y] == 'U') 
    {
        x--;
    }
    else if (maze[x][y] == 'R')
    {
        y++;
    }
    else if (maze[x][y] == 'D')
    {
        x++;
    } 
    else 
        y--;
    
    
    if (array[x][y] == -1)
    {
        array[x][y]=0;
        mark(maze, array, x, y);
        
    } 
    else if (array[x][y] == 1)
    {
        assoi(array, si, sj);
    } 
    else
    {
        zeros(array, si, sj);

    } 
    return 0;
}

int main(int argc, char **argv)
{
    ifstream infile(argv[1]);
    int n, m, i, j;
    infile >> n >> m;
    char** maze = new char*[n];
    for(int i = 0; i < n; i++)
      maze[i] = new char[m];

    int** array = new int*[n];
    for(int i = 0; i < n; i++)
      array[i] = new int[m];

    for (i=0; i<n; i++){
        for (j=0; j<m; j++){
            array[i][j]=-1;
        }
    }

    for (i=0; i<n; i++){
        for (j=0; j<m; j++){
        infile >> maze[i][j];
        if ((i == 0) && (maze[i][j]=='U'))
            array[i][j] = 1;
        if ((j == 0) && (maze[i][j]=='L'))
            array[i][j] = 1;
        if ((i == n-1) && (maze[i][j]=='D'))
            array[i][j] = 1;
        if ((j == m-1) && (maze[i][j]=='R'))
            array[i][j] = 1;
        }
    }

    // for (i=0; i<n; i++){
    //     for (j=0; j<m; j++){
    //     cout << array[i][j] << ' ';
    //     }
    //     cout << endl;
    // }
    // cout << endl;


    for (i=0; i<n; i++){
        for (j=0; j<m; j++){
            if (array[i][j]==-1){
                mark(maze, array, i, j);
            }
        }
    }

    int s=0;

    // for (i=0; i<n; i++){
    //     for (j=0; j<m; j++){
    //     cout << array[i][j] << ' ';
    //     }
    //     cout << endl;
    // }

    for (i=0; i<n; i++){
        for (j=0; j<m; j++){
            if (array[i][j] == 0){
                s++;
            }
        }
    }
    cout << s << endl;

 
    return 0;
}
