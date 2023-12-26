# MathZi

This is a library fully written in Zig and will be used to provide various mathematical operations and algorithms
natively. Many of these will be inspired by MATLAB (I'm a math student don't judge me) and another aim is to also
be able to have it work with C/C++ as well.

> Note: This library does require to link with `libc`

Goals:

- [ ] Runge-Kutta 4th Order algorithm (ODE Solver)
- [X] Euler's Numerical Method (ODE Solver)
- [X] Vec3 Abstraction: `src/vec3.zig`
- [ ] Matrix operations 
- [ ] Binomial Distribution 
- [ ] Normal Distribution 
- [ ] Poisson Distribution 
  - [ ] `.Probability_L` and `.Probability_R` are not working properly
- [ ] Compound Poisson Distribution 
- [X] Linear Regression 
- [ ] Polynomial Regression
- [ ] Incremental Five Moments `Stats` type 
- [X] Secant Method: `src/secant.zig` 
  - Won't do Newton since it requires derivative, secant allows us to approx that 
- [X] Newton Interpolation
- [X] Taylor Series
- [ ] Integral approximation using GaussQuadruture
- [X] Chinese Remainder Theorem


Matlab Functions to Implement: 
- `linspace`
- `zeros`
- `ones`
- `eye`
- `inv`
- `det`
- `eig`


Requires LibC: 

- `newtonInterpolation`
- `taylorSeries`
- `chineseRemainder`
