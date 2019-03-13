library(neurobase)
library(fslr)
library(extrantsr)
library(here)
setwd(here::here())

tilt = readnii("data/5mm_0_2.nii.gz")
corr = readnii("data/5mm_0_2_Tilt_1.nii.gz")

cc_tilt = largest_component(tilt > -400 & tilt < 1000)
cc_tilt = filler(img = cc_tilt)
cc_tilt = cc_tilt %>%
  oMath("MD", 2)
ind_tilt = getEmptyImageDimensions(cc_tilt)
otilted = mask_img(tilt, cc_tilt)
tilted = applyEmptyImageDimensions(otilted, inds = ind_tilt)

cc_corr = largest_component(corr > -200 & corr < 1000)
cc_corr = filler(img = cc_corr)
cc_corr = cc_corr %>%
  oMath("MD", 2)
ind_corr = getEmptyImageDimensions(cc_corr)
ocorred = mask_img(corr, cc_corr)
corred = applyEmptyImageDimensions(ocorred, inds = ind_tilt)

wcorr = window_img(corred)
wtilt = window_img(tilted)

pngname = "original_image.png"
png(pngname, height = 5, width = 10, units = "in", res = 600)
ortho2(wtilt, text = "Original\nImage")
dev.off()

pngname = "tilt_corr_image.png"
png(pngname, height = 5, width = 10, units = "in", res = 600)
ortho2(wcorr, text = "Tilt-Corrected\nImage")
dev.off()
