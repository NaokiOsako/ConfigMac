#include<bits/stdc++.h>
using namespace std;
int main() {
    string S;
    int Q;
    bool flag=true;
    cin >> S;
    cin >> Q;
    vector<int> a(Q), b(Q);
    vector<char> c(Q);
    deque<char> ans;

    for(int i=0; i<S.size(); i++){
	ans.push_back(S[i]);
    }
    for(int i=0; i<Q; i++){
	cin >> a[i];
	if(a[i] == 2)
	    cin >> b[i] >> c[i];
    }
 
    for(int i=0; i<Q; i++){
	if(a[i]==1)
	    flag = !flag;
	else if(b[i]==1)
	    if(flag)
		ans.push_front(c[i]);
	    else
		ans.push_back(c[i]);
	else if(b[i]==2)
	    if(flag)
		ans.push_back(c[i]);
	    else
		ans.push_front(c[i]);
    }
    if(!flag)
	reverse(ans.begin(), ans.end());

    for(char tmp: ans){
	cout << tmp ;
    }
    cout  << endl;
}

