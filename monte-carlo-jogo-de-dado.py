import numpy as np
import pandas as pd
import collections as cl
from matplotlib import pylab as plt

# Estimate the prob from the frequency
def obtain_relative_frequency(v):
 count = cl.Counter( v )
 x     = np.array( list( count.keys()   ) )
 fa    = np.array( list( count.values() ) )
 fr    = 1.0*fa/np.sum(fa)
 return x,fr

dado = np.arange(6)
print('dado=',dado) 

# N jogadas de um dado
N       = 10**5
results = np.random.choice(dado, size=N)
vx, vfr = obtain_relative_frequency( results )

# Plot with matplotlib 
plt.bar(dado, vfr)
plt.axhline(y=1/6, color='k', linestyle='--') 
plt.ylabel('Relative Frequency', fontsize=14) 
plt.title('Python: Monte Carlo simulation, N=%d'%(N))
plt.savefig( 'dado-N%d-from-py.png'%(N) )
plt.close()

