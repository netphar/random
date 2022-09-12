library(gamlss)
library(gamlss.dist)
library(fitdistrplus)


x <- c(1, 
       2, 2, 2, 2, 2, 
       3, 
       4, 
       5, 5, 5, 
       6, 
       7, 7, 7, 
       8, 8, 8, 
       9, 9, 9, 9, 9, 9, 9) # count vector
hist(x, breaks = seq(0,10))

# autofit using default gammlss distributions, using MLE to optimize and AIC as performance metric (since different distributions have different number of paramters and AIC accounts for it)
fit_discrete <- gamlss::fitDist(x, k = 2, type = "counts", trace = TRUE, try.gamlss = TRUE) # data is clearly discrete, so this family makes sense logically
fit_cont <- gamlss::fitDist(x, k = 2, type = "realplus", trace = TRUE, try.gamlss = TRUE) # but in light of ML approach lets also test any distributions defined on positive cont numbers
#  lets check uniform
unif_dist <- fitdistrplus::fitdist(x, "unif", discrete = TRUE)

summary(unif_dist)$aic # AIC 107.9721 for uniform
summary(fit_discrete)$aic # AIC 127.92 for Poisson and AIC 127.6225 for Double Poisson https://www.rdocumentation.org/packages/gamlss.dist/versions/6.0-3/topics/DPO 
summary(fit_cont)$aic # AIC 81.18824 for Box-Cox Power Exponential distribution https://rdrr.io/cran/gamlss.dist/man/BCPE.html

# we can also look at empirical bootstrapped estimations, so-called  
descdist(x, discrete = TRUE, boot=1000)
descdist(x, discrete = FALSE, boot=1000)




