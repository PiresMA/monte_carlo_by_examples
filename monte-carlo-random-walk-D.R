
# One sample of a random walk
random_walk = function(nsteps) {
  xo = 0 
  moeda = c(-1,1)
  alldx = sample(moeda, size=nsteps, replace=TRUE)
  x_t   =  c(xo, cumsum(alldx) )
  return( x_t )
}

# Estimate the prob from the frequency
obtain_relative_frequency = function(v) {
 df  = data.frame( table(v) ) 
 vx  = as.integer( as.vector(df$v) ) # ~ unique()
 fa  = as.integer( as.vector(df$Freq) ) 
 vfr = fa/sum(fa)  #table(vx)/length(vx) 
 return( data.frame(vx,vfr) )
}

# To obtain D from Monte Carlo simulation of random walks
D_from_random_walk = function(nsteps,n_samp){

  many_x_t = replicate(n_samp,random_walk(nsteps) ) 
  v        = many_x_t[nsteps,]    
  output = obtain_relative_frequency( v )   
  x      = output$vx
  fr     = output$vfr
  x2 = sum( (x^2)*fr ) 
  D  = x2/(2*nsteps)  
  #print( data.frame(nsteps,n_samp,D) )
  return( D )
}

tmax  = 100
vns   = 10^(1:3)
nexperiments = 50

listres=list()
for( i in 1:nexperiments){
 vtmax = rep(tmax,length(vns))
 res   = mapply( function(x, y) D_from_random_walk(x,y), vtmax,vns)
 listres[[i]]=res
}
matres = as.matrix(as.data.frame(listres))  #list ---> matrix
                   
nameout=sprintf('random-walk%d-nexperiments%d-D-from-R.png',tmax,max(vns),nexperiments)
png( nameout )

matplot(matres,pch=16,xlab='',ylab='',xaxt='n')
atx    = axTicks(1) 
myatx  = seq(min(atx),max(atx),1)
labels = sapply( myatx, function(i) as.expression(bquote(10^ .(i)) ) )

axis(1,at=myatx,labels=labels, cex.axis=1.2 )
abline(h=0.5,lty=2,lwd=2)
mtext(side=1,cex=2,line=2.6,expression(n[samples]))
mtext(side=2,cex=2,line=2.4,'Diffusion coefficient D')
mtext(side=3,cex=2,line=0.1,'R')
legend('topright',legend=c('Analytical'),col='black',lty=2,lwd=2,pch=NA,bty='n')

dev.off()

