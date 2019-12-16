# Estimate the prob from the frequency
obtain_relative_frequency = function(v) {
 df  = data.frame( table(v) ) 
 vx  = as.integer( as.vector(df$v) ) # ~ unique()
 fa  = as.integer( as.vector(df$Freq) ) 
 vfr = fa/sum(fa)  #table(vx)/length(vx) 
 return( data.frame(vx,vfr) )
}


dado = 1:6
print( c('dado=',dado) )


# N jogadas de uma dado
N       = 10^5
results = sample(dado,N,replace=TRUE) 
output  = obtain_relative_frequency( results ) 


png( sprintf('dado-N%d-from-R.png',N) ) 
title=sprintf('R: Monte Carlo simulation, N=%d',N)
xlabel=dado
barplot(output$vfr, main=title,
  names.arg=xlabel, ylab="Relative Frequency")
abline(h=1/length(dado),lty=2)
dev.off() # close


