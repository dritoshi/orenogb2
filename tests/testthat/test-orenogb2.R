test_that("check initialization of orenogb2 class", {
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
  
  expect_equal(
    "chr17",
    gb.quartz$chr
  )
}
)