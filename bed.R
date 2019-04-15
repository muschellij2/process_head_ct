library(neurobase)
library(extrantsr)
x = readnii("data/CQ500CT23_CT-PRE-CONTRAST-5MM-STD.nii.gz")


mask = x >= -100 & x <= 1000
cc = largest_component(mask)
filled = filler(cc, fill_size = 3)

# pngname = "head_image.png"
# png(pngname, height = 5, width = 5, units = "in", res = 600)
# ortho2(filled,
#        text = "Extracted Head",
#        crosshairs = FALSE
#        )
# dev.off()


pngname = "bed_image.png"
png(pngname, height = 5, width = 5, units = "in", res = 600)
ortho2(x,
       filled,
       window = c(-1000, -800),
       col.y = scales::alpha("red", 0.5),
       text = "Original Image\nExtracted Head (mask)",
       crosshairs = FALSE)

dev.off()
