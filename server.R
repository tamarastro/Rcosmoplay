
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

shinyServer(function(input, output) {

  
  output$dmPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    #x    <- faithful[, 2]
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)
    nbins=100
    zmin=input$zrange[1]
    zmax=input$zrange[2]
    #print(input$zrange)
    zseq=seq(zmin,zmax,by=((zmax-zmin)/(nbins-1)))
    
    # draw the histogram with the specified number of bins
    #hist(x, breaks = bins, col = 'darkgray', border = 'white')
    #magplot(zseq, cosgrowSigma8(z = zseq, OmegaM=input$om), type='l', xlab='z', ylab=expression(sigma[8]))
    magplot(zseq, cosdistDistMod(z=zseq, H0=input$H0, OmegaM=input$om, OmegaL=input$oll), type="l",xlab="redshift",ylab="Distance Modulus",main="Supernova Data")
    magerr(zdat, dmdat, ylo=dmerrdat/2.0)
    
  })
  output$dmPlotnorm <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    #x    <- faithful[, 2]
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)
    nbins=100
    zmin=input$zrange[1]
    zmax=input$zrange[2]
    #print(input$zrange)
    zseq=seq(zmin,zmax,by=((zmax-zmin)/(nbins-1)))
    
    # draw the histogram with the specified number of bins
    #hist(x, breaks = bins, col = 'darkgray', border = 'white')
    #magplot(zseq, cosgrowSigma8(z = zseq, OmegaM=input$om), type='l', xlab='z', ylab=expression(sigma[8]))
    magplot(zseq, cosdistDistMod(z=zseq, H0=input$H0, OmegaM=input$om, OmegaL=input$oll)-cosdistDistMod(z=zseq, H0=70., OmegaM=0.0, OmegaL=0.0), type="l",xlab="redshift",ylab="Distance Modulus",ylim=c(-0.7,0.7))
    magerr(zdat, dmdat-cosdistDistMod(z=zdat, H0=70.0, OmegaM=0.0, OmegaL=0.0), ylo=dmerrdat/2.0)
    
  })
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    #x    <- faithful[, 2]
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)
    #zseq=seq(0,1.5,by=0.01)
    
    # draw the histogram with the specified number of bins
    #hist(x, breaks = bins, col = 'darkgray', border = 'white')
    #magplot(zseq, cosgrowSigma8(z = zseq, OmegaM=input$om), type='l', xlab='z', ylab=expression(sigma[8]))
    magplot(zseq, cosdistLumDist(z=zseq, H0=input$H0, OmegaM=input$om, OmegaL=input$oll), type="l",xlab="redshift",ylab="Luminosity Distance")
    
  })
  
  output$chitext <- renderText({
    parm=c(input$om,input$oll,input$H0)
    chiout=coschi2(parm=parm, dat = dat)
    return(paste('The Chi Squared per d.o.f. for this cosmology is:',chiout))
  })

  # You can access the value of the widget with input$action, e.g.
  #output$value <- renderPrint({ input$action })
  output$optimparm <- eventReactive(input$optimal, {
    optimparm=optim(par=c(0.3,0.7,70), coschi2, dat=dat, control=list(parscale=c(0.01,0.01,0.1)), method="L-BFGS-B", lower=c(0.1,0.1,50), upper=c(2,2,200))
    #print(optimparm$par[1])
    return(paste('The best fit parameters are: Omega_M=',optimparm$par[1],', Omega_L=',optimparm$par[2],', H0=',optimparm$par[3]))
    #return(optimparm)
  })
  
  output$printoptim <- renderText({
    return(paste('The best fit parameters are:',output$optimparm))
  })
  
  
})
