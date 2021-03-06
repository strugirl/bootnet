print.netSimulator <- function(x, digits = 2, ...) summary(x, digits = digits, ...)

summary.netSimulator <- function(object, digits = 2, ...){
  name <- deparse(substitute(x))[[1]]
  if (nchar(name) > 10) name <- "object"
  
  Exclude <- c(
    "rep","id","correctModel","sensitivity","specificity","correlation","error","errorMessage"
  )
  # check number of levels:
  Conditions <- names(object)[!names(object)%in%Exclude]
  
  . <- NULL
  
  fun <- function(x,digits=2){
    paste0(round(mean(x,na.rm=TRUE),digits), " (",round(sd(x,na.rm=TRUE),digits),")")
  }
  
  # Summarize per case:
  df <- object %>% dplyr::select_("sensitivity","specificity","correlation",.dots = Conditions) %>% 
    dplyr::group_by_(.dots = Conditions) %>% dplyr::summarize_each(funs(fun(.,digits=digits))) %>% 
    dplyr::arrange_(~nCases) %>% as.data.frame
  # 
  # dfSD <- object %>% dplyr::select_("sensitivity","specificity","correlation",.dots = Conditions) %>% 
  #   dplyr::group_by_(.dots = Conditions) %>% dplyr::summarize_each(funs(sd(.,na.rm=TRUE))) %>% 
  #   dplyr::arrange_(~nCases) %>% as.data.frame
  
  row.names(df) <- NULL
  
  cat("=== netSimulator Results ===\n\n")
  cat("Mean (SD) values per varied levels:\n\n")
  print(df)
  # cat("Standard deviation per varied levels:\n\n")
  # print(dfSD)
  
  
  cat(paste0("\n\nUse plot(",name,") to plot results (nCases only), or as.data.frame(",name,") to see all results."))
  invisible(df)
}

# Plot method

plot.netSimulator <- function(x, xvar = "factor(nCases)",
                              yvar = c("sensitivity", "specificity", "correlation"),
                              xfacet = "measure", yfacet = ".", color = NULL,
                             ylim = c(0,1), print = TRUE,  xlab = "Number of cases", 
                              ylab, ...){
  # Check input:
  if (xvar != "factor(nCases)" & xlab != "Number of cases"){
    warning("argument 'xvar' is not 'factor(nCases)' while argument 'xlab' is still 'Number of cases'. X-axis label might be wrong.")
  }
  
  # Set y-axis label:
  if (missing(ylab)){
    if (xfacet != "measure"){
      ylab <- paste(yvar, collapse = "; ")
    } else {
      ylab <- ""
    }
  }
  
  # Gather:
  Gathered <- x %>% # dplyr::select_("nCases","sensitivity","specificity","correlation") %>%
    tidyr::gather_("measure","value",yvar)
  
  # AES:
  if (!is.null(color)){
    AES <- ggplot2::aes_string(x=xvar,y="value",fill=color)
  } else {
    AES <- ggplot2::aes_string(x=xvar,y="value")
  }
  
  # Create plot:
  g <- ggplot2::ggplot(Gathered, AES) + ggplot2::facet_grid(paste0(yfacet," ~ ",xfacet)) + 
    ggplot2::geom_boxplot() + ggplot2::theme_bw() + ggplot2::ylim(ylim[1],ylim[2]) + 
    ggplot2::ylab(ylab) + ggplot2::xlab(xlab)
  
  if (print){
    print(g)
    invisible(g)
  } else {
    return(g)
  }
}