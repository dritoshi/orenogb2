test_that("check initialization of orenogb2 class", {

  q01.bam <- system.file("extdata", "Quartz_01.Pou5f1.bam", package = "orenogb2")
  q02.bam <- system.file("extdata", "Quartz_02.Pou5f1.bam", package = "orenogb2")

  genome.ver <- 'mm10'
  zoom.power <- 1
  quartz.bam.files <- c(q01.bam, q02.bam)

  gb.quartz <- orenogb2$new(
    genome.ver = genome.ver,
    zoom.power = zoom.power,
    bam.files  = quartz.bam.files
  )

  # Coordination
  gb.quartz$chr      <- "chr17"
  gb.quartz$start.bp <- 35492880
  gb.quartz$end.bp   <- 35526079
  
  expect_equal(
    "chr17",
    gb.quartz$chr
  )
}
)

test_that("check getPositionBySymbol function", {

  s01.bam <- system.file("extdata", "Smart-Seq2_01.CDK2.bam", package = "orenogb2")
  s02.bam <- system.file("extdata", "Smart-Seq2_02.CDK2.bam", package = "orenogb2")

  genome.ver <- 'hg19'
  zoom.power <- 1
  smart2.bam.files <- c(s01.bam, s02.bam)
    
  gb.smart2 <- orenogb2$new(
    genome.ver = genome.ver,
    zoom.power = zoom.power,
    bam.files  = smart2.bam.files
  )
  gb.smart2$getPositionBySymbol('CDK2')
  
  expect_equal(
    "chr12",
    gb.smart2$chr
  )
}
)
