\name{orenogb2-class}
\Rdversion{1.1}
\docType{class}
\alias{orenogb2-class}

\title{Class \code{"orenogb2"}}
\description{
%%  ~~ A concise (1-5 lines) description of what the class is. ~~
}
\section{Extends}{

All reference classes extend and inherit methods from \code{"\linkS4class{envRefClass}"}.

}
\references{
%%  ~~put references to the literature/web site here~~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%%  ~~objects to See Also as \code{\link{~~fun~~}}, ~~~
%%  ~~or \code{\linkS4class{CLASSNAME}} for links to other classes ~~~
}
\examples{
showClass("orenogb2")
}
\keyword{classes}
\section{Fields}{
  \describe{
    \item{\code{genome.ver}:}{Object of class \code{character} ~~ }
    \item{\code{chr}:}{Object of class \code{character} ~~ }
    \item{\code{start.bp}:}{Object of class \code{numeric} ~~ }
    \item{\code{end.bp}:}{Object of class \code{numeric} ~~ }
    \item{\code{zoom.power}:}{Object of class \code{numeric} ~~ }
    \item{\code{bam.files}:}{Object of class \code{character} ~~ }
    \item{\code{orgdb}:}{Object of class \code{character} ~~ }
    \item{\code{bsgenome}:}{Object of class \code{character} ~~ }
  }
}
\section{Methods}{
  \describe{
    \item{\code{getPositionBySymbol(gene.name)}:}{ ~~ }
    \item{\code{getGRangesfromBam(bam.files, range, ...)}:}{ ~~ }
    \item{\code{chooseGenome()}:}{ ~~ }
    \item{\code{plotgb()}:}{ ~~ }
    \item{\code{printParams()}:}{ ~~ }
    \item{\code{initialize(genome.ver, zoom.power, bam.files)}:}{ ~~ }
  }
}
