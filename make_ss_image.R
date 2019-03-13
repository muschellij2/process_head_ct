library(neurobase)
library(extrantsr)
library(here)
setwd(here::here())

img = readnii("data/CQ500CT23_CT-PRE-CONTRAST-5MM-STD.nii.gz")
cc = largest_component(img > -400 & img < 1000)
inds = getEmptyImageDimensions(cc)
img = applyEmptyImageDimensions(img, inds = inds)
img = window_img(img)

ss = readnii("data/ss_CQ500CT23_CT-PRE-CONTRAST-5MM-STD.nii.gz")
ss = applyEmptyImageDimensions(ss, inds = inds)
ss = window_img(ss)

mask = readnii("data/CQ500CT23_CT-PRE-CONTRAST-5MM-STD_Mask.nii.gz")
mask = applyEmptyImageDimensions(mask, inds = inds)



pngname = "ss_image.png"
png(pngname, height = 5, width = 5, units = "in", res = 600)
ortho2(img, mask,
       col.y = scales::alpha("red", 0.5),
       text = "Image with\nBrain Mask (red)")
dev.off()

