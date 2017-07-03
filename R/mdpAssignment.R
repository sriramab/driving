n=0
S = c(1,2,3,4)
v0 = c(1,0,0,0)
A = c("dn","insp","pm", "cr")
v = matrix(v0,ncol=length(S),nrow=1)

colnames(v) = S
epsilon = 0.001
span = 2*epsilon
P = matrix(c(0.8,0.15,0.03,0.02,0,0.8,0.15,0.05,0,0,0.8,0.2,0,0,0,1),  nrow = 4,
           ncol = 4, byrow = TRUE)
dn = 0
ci = 0.2/5
pm = 1/5
cm = 1

r = c(0, 0.2/5, 1/5, 5/5)
R = matrix(c(dn, ci, -Inf , -Inf, dn, ci,pm, -Inf, dn, ci, pm, -Inf, -Inf, -Inf, -Inf, 1 ), nrow = 4, ncol = 4, byrow = TRUE)

Pr = array(P, dim=c(length(A),4,4))
Pr
while (span > epsilon) {
  n = n+1
  v_all = matrix(nrow=length(S),ncol=length(A)) # |S| x |A|
  for (a in 1:length(A)) {
    v_all[,a] = P[a,,] %*% v[n,] + r[,a]
  }
  v = rbind(v,apply(v_all,1,max))
  span = max(v[n+1,]-v[n,])-min(v[n+1,]-v[n,])
}
d = A[max.col(v_all,"first")]
rownames(v) = 0:n
v
d span


Q = P[1:3,1:3]
I = diag(1,nrow = 3)
Inv = solve(I-Q)
