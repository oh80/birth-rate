data{
  int N;
  real X[N];
  int Y[N];
}

parameters{
  real b1;
  real b2;
  real ep[N];
  real <lower=0> s_ep;
}

transformed parameters{
  real z[N];
  real q[N];
  for (i in 1:N){
    z[i]=b1+b2*X[i]+ep[i];
    q[i]=exp(z[i]);
  }
}

model{
  for(i in 1:N){
    ep[i]~normal(0,s_ep);
    Y[i]~poisson(q[i]) ;
  }
}