\name{plot.bootnet}
\alias{plot.bootnet}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Plots bootnet results
}
\description{
This function can be used to plot bootnet results by plotting all bootstrapped statistics as line or by plotting confidence intervals.
}
\usage{
\method{plot}{bootnet}(x, statistics, 
        plot,  CIstyle = c("default","SE","quantiles"), 
        rank = FALSE, sampleColor = "darkred", samplelwd = 1, bootColor = "black", 
        bootAlpha = 0.01, bootlwd = 0.9, areaAlpha = 0.1, 
        order = c("id", "sample", "mean"), decreasing = TRUE, perNode = FALSE, 
        legendNcol = 2, labels=TRUE, legend = TRUE,subsetRange = c(100,0), 
        area = !perNode, alpha = 0.05, onlyNonZero = FALSE, differenceShowValue, 
        differenceEdgeColor = TRUE, verbose = TRUE, panels = TRUE, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
A \code{bootnet} object
}
\item{statistics}{
The types of statistics to plot. \code{c("intercept", "strength", "closeness", "betweenness") } plots all nodewise statistics whereas \code{c("edge","distance")} plots all pairwise statistics. Defaults to \code{"edge"} for regular bootstrap and \code{c("strength", "closeness", "betweenness")} for node and person drop bootstrap.}
\item{plot}{
Character string indicating what to plot. Can be \code{"area"} to produce a graph with the area indicating the confidence region, or \code{"difference"} producing a plot showing significant differences. Other options are \code{"line"} and \code{"interval"}, which are currently unstable and not recommended to use.
}
\item{CIstyle}{
 Style of CIs to construct. \code{"SE"} shows the sample statistic plus and minus two times the standard deviation of bootstraps, and \code{"quantiles"} the area between the 2.5th and 97.5th quantile. Defaults to  \code{"SE"} for strength and betweenness and \code{"quantiles"} otherwise
}
\item{rank}{
  Logical, should plots show rank of statistics instead of statistics?
}
  \item{sampleColor}{
Color of the original sample line
}
  \item{samplelwd}{
Line width of the original sample line
}
  \item{bootColor}{
Color of the bootstrap lines
}
  \item{bootAlpha}{
Alpha of the bootstrap lines
}
  \item{bootlwd}{
Line width of the bootstrap lines
}
\item{areaAlpha}{
Alpha of the area
}
  \item{order}{
    String indicating how to order nodes. \code{"id"} will order nodes based on their name, \code{"mean"} will order nodes based on the average bootstrapped value of the first statistic in \code{statistics}, and \code{"sample"} will order the nodes as done in  \code{"mean"} but orders ties based on their sample value.
  }
  \item{decreasing}{
    Logical indicating if the ordering is decreasing or increasing.
  }
  \item{perNode}{
    Logical, should centrality estimates per node be plotted instead of correlation with original parameter. Only used in node and person drop bootstrap.
  }
  \item{legendNcol}{
  Number of columns in the legend if \code{perNode = TRUE}.
  }
  \item{labels}{
    Logical, should labels be plotted?
  }
  \item{legend}{
    Logical, should the legend be plotted?
  }
  \item{subsetRange}{
  Range in percentages of the x-axis in node and person drop plots.
  }
  \item{area}{
   Logical, should the confidence area be plotted?
  }
    \item{alpha}{
   Signifiance level used in \code{plot = "difference"}.
  }
  \item{onlyNonZero}{Logical used when \code{plot = "difference", statistics = "edge"}, should only edges be included that were nonzero in the estimated network structure?}
  \item{differenceShowValue}{Logical used when \code{plot = "difference"}. Should values be shown in the diagonal of the difference plot?
  }
   \item{differenceEdgeColor}{Logical used when \code{plot = "difference", statistics = "edge"}. Should diagonal blocks be colored according to default edge colors?
  }
  \item{verbose}{Should expected alpha be printed?}
  \item{panels}{Logical, should panel titles be printed?}
  \item{\dots}{Not used.}
}

\value{
A \code{ggplot2} object.
}
\author{
Sacha Epskamp <mail@sachaepskamp.com>
}
