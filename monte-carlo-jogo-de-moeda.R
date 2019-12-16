# Estimate the prob from the frequency
obtain_relative_frequency = function(v) {
 df  = data.frame( table(v) ) 
 vx  = as.integer( as.vector(df$v) ) # ~ unique()
 fa  = as.integer( as.vector(df$Freq) ) 
 vfr = fa/sum(fa)  #table(vx)/length(vx) 
 return( data.frame(vx,vfr) )
}


moeda = c(-1,1)


# N jogadas de uma moeda
N       = 10^5
results = sample(moeda,N,replace=TRUE) 
output  = obtain_relative_frequency( results ) 


png( sprintf('moeda-N%d-from-R.png',N) ) 
title=sprintf('R: Monte Carlo simulation, N=%d',N)
xlabel=c('cara (-1) ','coroa (1)')
barplot(output$vfr, main=title,
  names.arg=xlabel, ylab="Relative Frequency")
abline(h=1/length(moeda),lty=2)
dev.off() # close

