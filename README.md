Orenogb
====

Ore no Genome Browser

## Description
- wrapper of ggbio
- just type simple command on your terminal
- beautiful visualization by ggbio and ggplot2
- semantic zoom
- eaily loading of transcriptome annotation
- search by gene Symbol
- choose species

## Demo

    genome.ver  <- 'mm10'
    zoom.power  <- 1
    quartz.bam.files   <- c(
      "~/Dropbox_RIKEN/Public_ACCCBiT/Data/Quartz-Seq/bam/Quartz_01.bam",
      "~/Dropbox_RIKEN/Public_ACCCBiT/Data/Quartz-Seq/bam/Quartz_02.bam"
    )
    
    gb.quartz <- orenogb2$new(
      genome.ver  = genome.ver,
      zoom.power  = zoom.power,
      bam.files   = quartz.bam.files
    )
    
    # Coordination
    gb.quartz$chr      <- "chr17"
    gb.quartz$start.bp <- 35492880
    gb.quartz$end.bp   <- 35526079
    gb.quartz$plotgb()

![demo](inst/extdata/demo1.png)

### Semantic Zoom

    genome.ver  <- 'mm10'
    zoom.power  <- 1/200
    quartz.bam.files   <- c(
      "~/Dropbox_RIKEN/Public_ACCCBiT/Data/Quartz-Seq/bam/Quartz_01.bam",
      "~/Dropbox_RIKEN/Public_ACCCBiT/Data/Quartz-Seq/bam/Quartz_02.bam"
    )
    
    gb.quartz <- orenogb2$new(
      genome.ver  = genome.ver,
      zoom.power  = zoom.power,
      bam.files   = quartz.bam.files
    )
    
    # Coordination
    gb.quartz$chr      <- "chr17"
    gb.quartz$start.bp <- 35492880
    gb.quartz$end.bp   <- 35526079
    gb.quartz$plotgb()

![demo](inst/extdata/demo2.png)

### Search by Gene Symbol

    genome.ver  <- 'hg19'
    zoom.power  <- 1
    smart2.bam.files   <- c(
      "~/Dropbox_RIKEN/Public_ACCCBiT/Data/Smart-Seq2/bam/Smart-Seq2_01.bam",
      "~/Dropbox_RIKEN/Public_ACCCBiT/Data/Smart-Seq2/bam/Smart-Seq2_02.bam"
    )
    
    gb.smart2 <- orenogb2$new(
    genome.ver  = genome.ver,
    zoom.power  = zoom.power,
    bam.files   = smart2.bam.files
    )
    gb.smart2$getPositionBySymbol('CDK2')
    gb.smart2$plotgb()

![demo](inst/extdata/demo3.png)

## Usage

    R> library(orenogb2)

## Requirement
- R
- Bioconductor Software Packages
    - ggbio
    - GenomicRanges
    - GenomicAlignments
- Bioconductor Annotation Packages
    - Mus.musculus, Homo.sapiens, ...
    - BSgenome.Mmusculus.UCSC.mm10, BSgenome.Hsapiens.UCSC.hg19, ...

## Install

    $ git clone git@github.com:dritoshi/orenogb2.git
    $ cd orenogb2
    $ sudo R
    R> source("http://bioconductor.org/biocLite.R")
    R> biocLite(c("ggbio", "GenomicRanges", "GenomicAlignments")
    R> biocLite(c("Mus.musculus", "BSgenome.Mmusculus.UCSC.mm10"))
    R> biocLite(c("Homo.sapiens", "BSgenome.Hsapiens.UCSC.hg19"))    

## ToDo
- wapper by shell script

## Contribution

## Licence

[MIT](https://github.com/dritoshi/orenogb/blob/master/LICENCE)

## Author

[dritoshi](https://github.com/dritoshi)
