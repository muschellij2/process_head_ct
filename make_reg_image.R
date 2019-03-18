library(neurobase)
library(extrantsr)
library(ichseg)
library(here)
setwd(here::here())

img = readnii("data/CQ500CT23_CT-PRE-CONTRAST-5MM-STD.nii.gz")
cc = largest_component(img > -400 & img < 1000)
inds = getEmptyImageDimensions(cc)
img = applyEmptyImageDimensions(img, inds = inds)

template_file = system.file("scct_unsmooth.nii.gz", package = "ichseg")
reg = registration(filename = img, template.file = template_file,
                   typeofTransform = "SyN",
                   interpolator = "Linear")
wout = window_img(reg$outfile)
timg = readnii(template_file)
timg = window_img(timg)

pngname = "reg_image.png"
png(pngname, height = 5, width = 8, units = "in", res = 600)
double_ortho(
  wout,
  timg,
  text = "Registered\nImage (left)",
  text.y = 33, crosshairs = FALSE)
text("Template\n(right)", col = "white", x = 0.9, y = 0.08, cex = 1.25)
dev.off()



mask = readnii("data/CQ500CT23_CT-PRE-CONTRAST-5MM-STD_Mask.nii.gz")
mask = applyEmptyImageDimensions(mask, inds = inds)
ss = mask_img(img, mask)

ss_template_file = system.file("scct_unsmooth_SS_0.01.nii.gz", package = "ichseg")
ss_reg = registration(filename = ss, template.file = ss_template_file,
                   typeofTransform = "SyN",
                   interpolator = "Linear")
ss_out = window_img(ss_reg$outfile)
ss_timg = readnii(ss_template_file)
ss_timg = window_img(ss_timg)

pngname = "reg_ss_image.png"
png(pngname, height = 5, width = 8, units = "in", res = 600)
double_ortho(
  ss_out,
  ss_timg,
  text = "Registered\nBrain (left)",
  text.y = 33, crosshairs = FALSE)
text("Template Brain\n(right)", col = "white", x = 0.88, y = 0.08, cex = 1.25)
dev.off()


pngname = "reg_ss2_image.png"
png(pngname, height = 5, width = 8, units = "in", res = 600)
double_ortho(
  ss_out,
  timg,
  text = "Registered\nBrain (left)",
  text.y = 33, crosshairs = FALSE)
text("Template\n(right)", col = "white", x = 0.88, y = 0.08, cex = 1.25)
dev.off()
