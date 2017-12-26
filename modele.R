##################################################
##### PROJET HMM ET SMC
##### Generation de la serie
##### (26/12/2017)
##################################################

rm(list = ls())
wd <- "C:/Users/Samuel/Documents/ENSAE - HMM/monteCarloSequentielle"
setwd(wd)
getwd()

##################################################
##### PARAMETRES DU MODELE

n <- 10000

rho <- 0.5
delta <- 0.2
beta1 <- 0
beta2 <- 0
beta <- c(beta1, beta2)
d <- rep(12, n)

##################################################
##### FONCTIONS DU MODELE

### Engendre le processus latent auto-regressif stationnaire Xi
### sur un temps de duree n, avec les parametres delta et rho
genXi <- function(delta, rho, n) {
  sd <- delta / sqrt(1 - (rho ^ 2))
  xi <- rnorm(n = 1, mean = 0, sd = sd)
  res <- c(xi)
  for (i in 2:n) {
    xi <- rnorm(n = 1,
                mean = (rho * xi),
                sd = delta)
    res <- append(res, xi)
  }
  return(res)
}

genPhotonCount <- function(d, beta, delta, rho, n) {
  xi <- genXi(delta, rho, n)
  res <- c()
  for (i in 1:n) {
    lambda <- d[i] * exp(beta[1] + (beta[2] * i / n) + xi[i])
    y <- rpois(n = 1, lambda = lambda)
    res <- append(res, y)
  }
  return(res)
}

##################################################
##### TESTS

### Generation du processus 'Xi'

simulXi <- genXi(delta, rho, n)

plot(simulXi,
     main = "Processus 'Xi' (latent) auto-r�gressif stationnaire",
     xlab = "Temps t",
     ylab = "Valeur de Xi observ�e")

simulPhotoCount <- genPhotonCount(d, beta, delta, rho, n)

plot(simulPhotoCount)