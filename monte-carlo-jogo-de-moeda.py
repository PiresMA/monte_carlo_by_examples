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

moeda = np.array([-1,1])

# N jogadas de uma moeda
N       = 10**5
results = np.random.choice(moeda, size=N)
vx, vfr = obtain_relative_frequency( results )

# Plot with matplotlib 
xlabel=['cara (-1)','coroa (1)']
plt.bar(xlabel, vfr)
plt.axhline(y=1/2, color='k', linestyle='--')
plt.ylabel('Relative Frequency', fontsize=14)
plt.title('Python: Monte Carlo simulation, N=%d'%(N))
plt.savefig( 'moeda-N%d-from-python.png'%(N) )
plt.close()

