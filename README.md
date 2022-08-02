# SPB
This is a collection of MATLAB codes to reproduce all figures in the paper "The springback penalty for robust signal recovery" by Congpei An, Hao-Ning Wu, and Xiaoming Yuan, which is published with DOI [j.acha.2022.07.002](https://doi.org/10.1016/j.acha.2022.07.002).

This collection consists of one demo and three folders. To reproduce the figures in the mentioned paper, you may need the [MATLAB Parallel Computing Toolbox](https://www.mathworks.com/products/parallel-computing.html). If this toolbox is unavailable, one may need to replace all command "parfor" with "for". 

Just run the demo to see how the springback-penalized model works!


# functions
The folder entitled "functions" contains subroutines that implement sparse optimization models, including 
* ADMM_L1 for the unconstrained L1 model solved by ADMM
* DCA_L12 for the unconstrained L1-L2 model solved by DCA+ADMM
* DCA_MCP for the unconstrained MCP model solved by DCA+ADMM
* DCA_SPB for the unconstrained springback model solved by DCA+ADMM
* DCA_SPBconstrained for the constrained springback model solved by DCA+ADMM
* DCA_SPBconstrainednoisy for the constrained springback model (with noisy measurements) solved by DCA+ADMM


# Reproducing
The folder entitled "Reproducing" contains codes for reproducing all figures in the mentioned paper, including
* plotshrinkage.m: Fig. 1
* safeguardedalpha.m: Fig. 2
* groundtruth.m: Figs. 3 and 6
* noisefreetestonRIPmatrices: Fig. 4
* noisefreetestonoverDCT: Fig. 5
* noisytestonRIPandoverDCT.m: Fig .7
* numericalverification.m: Fig.8

Besides these scripts, there are eponymous MATLAB functions with the suffix "forPC". To execute for-loop iterations in parallel on MATLAB, we need the body of the parfor-loop to be independent. Such a body is defined by those "forPC" functions, where "PC" stands for parallel computing.


# Utilities
The folder entitled "Utilities" contains codes written by other researchers, to whom the credit must go. These codes are available online.
* DCATL1-master: Transformed L1-related codes

  Zhang, S., & Xin, J. (2018). Minimization of transformed L1 penalty: theory, difference of convex function algorithm, and robust application in compressed sensing. Mathematical Programming, 169(1), 307-336.
  
  Codes available at [https://github.com/zsivine/DCATL1](https://github.com/zsivine/DCATL1).
* IRucLq: IRLS-Lp-related codes

  Lai, M. J., Xu, Y., & Yin, W. (2013). Improved iteratively reweighted least squares for unconstrained smoothed \ell_q minimization. SIAM Journal on Numerical Analysis, 51(2), 927-957.
  
  Codes available at [https://xu-yangyang.github.io/codes/IRucLq.zip](https://xu-yangyang.github.io/codes/IRucLq.zip)
* sparsify_0_5: AIHT-related codes
  
  Blumensath, T., & Davies, M. E. (2009). Iterative hard thresholding for compressed sensing. Applied and computational harmonic analysis, 27(3), 265-274.
  
  Codes available at [http://www.personal.soton.ac.uk/tb1m08/sparsify/sparsify_0_5.zip](http://www.personal.soton.ac.uk/tb1m08/sparsify/sparsify_0_5.zip).
* POR: for projection onto the ball $|x|_2\leq\tau$
  
  The Proximity Operator Repository [http://proximity-operator.net/](http://proximity-operator.net/)
