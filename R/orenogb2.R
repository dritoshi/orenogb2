#' Package orenogb2 
#' 
#' @name orenogb2-package
#' @docType package
#' @aliases orenogb2 orenogb2-package
#'
#' @author
#' Author: Itoshi NIKAIDO
#' Maintainer: Itoshi NIKAIDO. \email{dritoshi@@gmail.com}
#'
#' @import methods
#' @exportPattern '^[^\\.]'
NULL

#' Class orenogb2
#'
#' orenogb2 Class (description)
#'
#' \code{orenogb2} class is a reference class (details).
#'
#' @name orenogb2-class
#' @docType class
#'
#' @section Fields:
#' \itemize{
#'   \item genome.ver, mm10, hg19 etc.
#'   \item chr. chr1, chrX etc.
#'   \item start.bp, genomic coordination (bp)
#'   \item end.bp, genomic coordination (bp)
#'   \item zoom.power, 1, 1/100 etc.
#'   \item bam.files (test01.bam,test02.bam)
#' }
#' @section Contains:
#' NULL
#' @section Methods:
#' \itemize{
#'   \item plotgb
#'   \item getPositionBySymbol
#' }
#' @keywords documentation
orenogb2 <- setRefClass(
  "orenogb2",
  fields = list(
    genome.ver  = "character",
    chr         = "character",
    start.bp    = "numeric",
    end.bp      = "numeric",
    zoom.power  = "numeric",
    bam.files   = "character",
    orgdb       = "character",
    bsgenome    = "character"
  ),
  methods = list(
    initialize = function(
      genome.ver  = genome.ver,
      zoom.power  = zoom.power,
      bam.files   = bam.files) {

      genome.ver  <<- genome.ver
      zoom.power  <<- zoom.power
      bam.files   <<- bam.files
      
      chooseGenome()
      printParams()      

      library(orgdb,    character.only = TRUE)
      library(bsgenome, character.only = TRUE)

    },
    printParams = function() {
      cat("### Genome:",    genome.ver,  "\n")
      # cat("### Position:",  paste0(chr, ":", start.bp, "-", end.bp), "\n")
      cat("### Zoom:",      zoom.power,  "\n")
      cat("### bam files:", bam.files,   "\n")
      cat("### Orgdb:",     orgdb,       "\n")
      cat("### BSgenome:",  bsgenome,    "\n")            
    },
    plotgb = function() {
      library("ggbio")
      library("GenomicAlignments")

      cat("### Start plot...\n")
      # make a GenomicRanges object
      range <- GRanges(chr, IRanges(start.bp, end.bp))

      # ideogram track
      cat("### build ideogram...\n")
      p.ideo <- Ideogram(genome = genome.ver, subchr = chr) + xlim(range)

      # genes
      cat("### build genes...\n")
      p.txdb <- autoplot(eval(parse(text = orgdb)), which = range)

      # background
      # bg   <- BSgenome.Mmusculus.UCSC.mm10
      cat("### build background...\n")
      bg <- eval(parse(text = bsgenome))
      p.bg <- autoplot(bg, which = range)

      # bam
      cat("### build reads from bam data...\n")
      bam.views  <- BamViews(bam.files, bamRanges = range)
      bam.galign <- readGAlignmentsFromBam(bam.views)

     # draw my track
     cat("### draw all tracks...\n")
     tks <- tracks(
       p.ideo,
       ref      = p.bg,  
       gene     = p.txdb,  
       heights  = c(1, 1, 4)
     )
     for (i in seq_along(bam.files)) {
        sample.name = sub('.bam', '', basename(bam.files[i]))
        p.mis <- autoplot(bam.files[i], bsgenome = bg, which = range, stat = "mismatch")
 
        sample.name <- sub('-', '', sample.name)
        tracks.str <- paste0('tracks(', sample.name, ' = p.mis, heights = 2)')
        cat('### ', tracks.str, "\n")
        tks <- tks + eval(parse(text = tracks.str))
 
      }
      tks <- tks + xlim(range)
      tks <- tks + ggbio:::zoom(zoom.power)

      # output
      print(tks)
    },
    chooseGenome = function() {
      switch(genome.ver,
        "mm10" = {orgdb <<- 'Mus.musculus'; bsgenome <<- 'BSgenome.Mmusculus.UCSC.mm10'},
        "hg19" = {orgdb <<- 'Homo.sapiens'; bsgenome <<- 'BSgenome.Hsapiens.UCSC.hg19'}
      )
    },
    getGRangesfromBam = function(bam.files, range, ...) {
      param <- ScanBamParam(
        what  = c("pos", "qwidth"),
        which = range,
        flag  = scanBamFlag(isUnmappedQuery = FALSE)
      )
      scanBam(bamFile, ..., param = param)[[1]]
    },
    getPositionBySymbol = function(gene.name) {
      switch(orgdb,
        "Mus.musculus" = {idx <- c(18, 11, 49, 50); symbol.idx <- 18},
        "Homo.sapiens" = {idx <- c(19, 11, 51, 52); symbol.idx <- 19}
      )      
      cls <- columns(eval(parse(text = orgdb)))[idx]
      kt  <- keytypes(eval(parse(text = orgdb)))[symbol.idx]  # SYMBOL

      res <- select(eval(parse(text = orgdb)), keys = gene.name, columns = cls, keytype = kt)
      chr      <<- paste0("chr", res[1,]$CHR[1])
      start.bp <<- min(res[1,]$TXSTART)
      end.bp   <<- max(res[1,]$TXEND)
    }
  )
)
#' draw a genome region
#'
#' This method draw specific genome region.
#'
#' @name plotgb
#' @keywords plot
#' @examples
#' q01.bam <- system.file("extdata", "Quartz_01.Pou5f1.bam", package = "orenogb2")
#' q02.bam <- system.file("extdata", "Quartz_02.Pou5f1.bam", package = "orenogb2")
#' genome.ver <- 'mm10'
#' zoom.power <- 1
#' quartz.bam.files <- c(q01.bam, q02.bam)
#' 
#' gb.quartz <- orenogb2$new(
#'   genome.ver = genome.ver,
#'   zoom.power = zoom.power,
#'   bam.files  = quartz.bam.files
#' )
#' 
#' # Coordination
#' gb.quartz$chr      <- "chr17"
#' gb.quartz$start.bp <- 35492880
#' gb.quartz$end.bp   <- 35526079
#'
#' png("Pou5f1.png", height = 600, width = 600)
#' gb.quartz$plotgb()
#' dev.off()
#' 
#' gb.quartz$zoom.power <- 1/200
#' png("Pou5f1.zoom.png", height = 600, width = 600)
#' gb.quartz$plotgb()
#' dev.off()
NULL

#' retrive genome coordination by gene name
#'
#' This method search genome region by gene name.
#'
#' @name getPositionBySymbol
#' @keywords search
#' @examples
#' s01.bam <- system.file("extdata", "Smart-Seq2_01.CDK2.bam", package = "orenogb2")
#' s02.bam <- system.file("extdata", "Smart-Seq2_02.CDK2.bam", package = "orenogb2")
#' cat(getwd(), "\n")
#'
#' genome.ver <- 'hg19'
#' zoom.power <- 1
#' smart2.bam.files <- c(s01.bam, s02.bam)
#'
#' gb.smart2 <- orenogb2$new(
#'   genome.ver = genome.ver,
#'   zoom.power = zoom.power,
#'   bam.files  = smart2.bam.files
#' )
#' gb.smart2$getPositionBySymbol('CDK2')
#'
#' png("CDK2.png", height = 600, width = 600)
#' gb.smart2$plotgb()
#' dev.off()
NULL