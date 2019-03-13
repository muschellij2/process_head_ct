library(neurobase)
library(fslr)
library(extrantsr)
library(here)
setwd(here::here())

fnames = list(std = "data/CQ500CT23_CT-PRE-CONTRAST-5MM-STD.nii.gz",
              bone = "data/CQ500CT23_CT-PRE-CONTRAST-BONE.nii.gz",
              thin = "data/CQ500CT23_CT-PRE-CONTRAST-THIN.nii.gz",
              post = "data/CQ500CT23_CT-5mm-POST-CONTRAST.nii.gz",
              cormack = "data/cCQ500CT23_CT-PRE-CONTRAST-5MM-STD.nii.gz")

imgs = check_nifti(fnames)
wimgs = lapply(imgs, window_img)
slices = lapply(wimgs, function(x) {
  copyNIfTIHeader(img = x, x[,,ceiling(dim(x)[3]/2)])
})

img = imgs$bone
cc_bone = largest_component(img > -400 & img < 1000)
cc_bone = filler(img = cc_bone)
bone = mask_img(img, cc_bone)
# bone = drop_empty_dim(cc_bone, other.imgs = img)
# bone = bone$other.imgs

smooth_bone = fslsmooth(fnames$bone, sigma = 1, retimg = TRUE)
pm = perona_malik(fnames$bone, n_iter = 10, conductance = 5)
# ortho2(imgs$bone, window = c(0, 100), text = "Bone")
# ortho2(smooth_bone, window = c(0, 100), text = "Smoothed Bone")
# ortho2(imgs$std, window = c(0, 100), text = "Standard")
# ortho2(pm, window = c(0, 100), text = "PM-Smoothed Bone")
# ortho2(smooth_bone, window = c(0, 100), text = "Smoothed Bone")

bone = (bone - min(bone)) / (max(bone) - min(bone)) * 100
bone = mask_img(bone, cc_bone)
bone = finite_img(bone)
L = list("(B) Bone Windowed" = imgs$bone,
         "(C) Bone (Gaussian)" = smooth_bone,
         "(D) Bone (Perona-Malik)" = pm,
         "(E) Soft-Tissue" = imgs$std)
L = lapply(L, window_img)
L = c(list("(A) Bone Non-Windowed" = bone),
      L)
# multi_overlay(
#   L,
#   text = gsub(" ", "\n", names(L)),
#   text.x =
#     rep(0.5, length(L)),
#   text.y =
#     rep(1.4, length(L)),
#   text.cex =
#     rep(2, length(L)))

L = c(L,
      list("(F) Thin-slice" = wimgs$thin))


slices = lapply(L, function(x) {
  copyNIfTIHeader(img = x, x[ 40:452, 40:472, ceiling(dim(x)[3]/2), drop = FALSE],
                  drop = FALSE)
})
slices = lapply(slices, function(x) {
  pixdim(x)[4] = 1
  x
})
pngname = "overlaid_slices.png"
png(pngname, height = 5, width = 16, units = "in", res = 600)
multi_overlay(
  slices,
  z = 1,
  text = gsub(" ", "\n", names(slices)),
  text.x =
    rep(0.5, length(slices)),
  text.y =
    rep(1.2, length(slices)),
  text.cex =
    rep(2.3, length(slices)))
dev.off()
knitr::plot_crop(pngname)



