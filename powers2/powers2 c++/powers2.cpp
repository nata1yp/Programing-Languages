#include <iostream> 
#include <fstream>

using namespace std;


struct node { 
    int data; 
    struct node *link; 
}; 
struct node *top; 
  
// Utility function to add an element data in the stack 
 // insert at the beginning 
void push(int data) 
{ 
    // create new node temp and allocate memory 
    struct node* temp; 
    temp = new node(); 
  
    // check if stack (heap) is full. Then inserting an element would 
    // lead to stack overflow 
    if (!temp) { 
        exit(1); 
    } 
  
    // initialize data into temp data field 
    temp->data = data; 
  
    // put top pointer reference into temp link 
    temp->link = top; 
  
    // make temp as top of Stack 
    top = temp; 
} 

void pop() 
{ 
    struct node* temp; 
  
    // check for stack underflow 
    if (top == NULL) { 
        exit(1); 
    } 
    else { 
        temp = top; 
        top = top->link; 
        temp->link = NULL; 
        free(temp); 
    } 
}

void display()  
{ 

    if (top == NULL) { 
        exit(1); 
    } 
    else { 
        while (top != NULL) { 
            cout <<  top->data; 
            top = top->link;
	    if (top != NULL) cout << ",";
        } 
    } 
} 

  
// Function to print k numbers which are powers of two 
// and whose sum is equal to n 
void FindAllElements(int n, int k) 
{ 
    // Initialising the sum with k 
	int sum, counter, power, num, j, flag;
	sum = k; 
	//num=1;
	power=1;
	counter=1;
	flag = 0;
  
    for (j = k-1; j >= 0; --j) 
	{ 
		num = 1;
        while (sum + num <= n) 
		{ 
              		sum += num; 
            		num *= 2; 
        }

		if (num==power)
		{
			counter++;
			flag=1;			
		}	
		else if (flag == 1)
		{
			push(counter);
			power = power/2;
			while (num < power)
			{
				push(0);
				power = power/2;
			}
			counter = 1;
		}	
		else
		{	
			flag = 1;
			power = num;
			counter = 1;
		}
		

		if (sum == n)
		{
			push(counter);
			while (power > 2)
			{
				push(0);
				power = power/2;
			}

			push(j);
			break;		
		}		 
     } 
  
   // Impossible to find the combination 
    if (sum != n) 
	{
			while (top != NULL)
				pop();
        	cout << "[]\n"; 
    } 
  
        else
	{ 
		cout << "[";
		display();
		cout << "]\n";
	}
} 
  
// Driver code 
int main(int argc, char **argv) 
{ 
    int i, t, n, k;
	ifstream infile;
	infile.open(argv[1]);
	infile >> t;
	for (i=0; i<t; i++)
	{
		infile >> n;
		infile >> k;
		FindAllElements(n, k); 
		
	}
	infile.close();
  
    return 0; 
} 


/*
Voithitikoi kwdikes:
1. https://www.geeksforgeeks.org/represent-n-as-the-sum-of-exactly-k-powers-of-two-set-2/
2. https://www.geeksforgeeks.org/implement-a-stack-using-singly-linked-list/
*/
