
import numpy as np
import collections as cl
from matplotlib import pylab as plt

# One sample of a random walk
def one_random_walk(nsteps=5):
  xo = 0
  moeda = [-1,1]
  alldx = np.cumsum(np.random.choice(moeda,size=nsteps))
  trajectory = np.concatenate( (xo,alldx), axis=None) 
  return trajectory
  
# Estimate the prob from the frequency
def obtain_relative_frequency(v):
 count = cl.Counter( v )
 x     = np.array( list( count.keys()   ) )
 fa    = np.array( list( count.values() ) )
 fr    = 1.0*fa/np.sum(fa)
 return x,fr

# To obtain D from Monte Carlo simulation of random walks
def D_from_random_walk(nsteps,ns):
  many_x_t  = [ one_random_walk(nsteps) for sample in range(ns) ]
  x_at_tmax = [ elem[-1] for elem in many_x_t ]
  
  vx, vfr = obtain_relative_frequency( x_at_tmax )  
  x2 = np.sum( (vx**2)*fr )
  D  = x2/(2*tmax) 
  
  return D


fig  = plt.figure()
ax   = plt.gca()

tmax = 100
nexperiments = 200
vns  = [ 10**j for j in range(1,4,1) ]

for i in range(nexperiments):  
  vD   = [ D_from_random_walk(tmax,nsamples) for nsamples in vns ]

  plt.plot(vns,vD,'o')
  ax.set_xscale('log')   

plt.title('Python')
plt.ylabel(r'Diffusion coefficient $D$', fontsize=14)
plt.xlabel('$n_{samples}$ ')
plt.axhline(y=0.5, color='k', linestyle='--',label='Analytical')
plt.legend()  

nameout=('random-walk%d-nexperiments%d-D-from-python.png')%(tmax,nexperiments)
plt.savefig( nameout )
plt.close()

