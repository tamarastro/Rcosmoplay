
library(shiny)
library(celestial)
library(magicaxis)

#read in data:
dat=read.table("MLCS.FITRES")
zdat=dat[,3]
dmdat=dat[,5]
dmerrdat=dat[,6]

coschi2=function(parm,dat){
  om=parm[1]
  oll=parm[2]
  H0=parm[3]
  zdat=dat[,3]
  dmdat=dat[,5]
  dmerrdat=dat[,6]
  testdist=cosdistDistMod(z=zdat,OmegaM = om,OmegaL = oll,H0 = H0) #Warning H0 may need tweaking
  chi2=sum((testdist-dmdat)^2/dmerrdat^2)
  chi2dof=chi2/288
  return(chi2dof)
}