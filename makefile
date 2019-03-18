all: index.pdf README.md index.md figures

index.pdf: index.Rmd 
	Rscript -e "rmarkdown::render('index.Rmd')"

README.md: README.Rmd 
	Rscript -e "rmarkdown::render('README.Rmd')"

figures: original_image.png overlaid_slices.png reg_image.png reg_ss_image.png \
reg_ss2_image.png ss_image.png tilt_corr_image.png

ss_image.png: make_ss_image.R
	Rscript -e "source('make_ss_image.R')"

reg_image.png reg_ss2_image.png reg_ss_image.png: make_reg_image.R 
	Rscript -e "source('make_reg_image.R')"

original_image.png tilt_corr_image.png: make_tilted_image.R
	Rscript -e "source('make_tilted_image.R')"

overlaid_slices.png: plotting_overlays.R
	Rscript -e "source('plotting_overlays.R')"		

index.md: index.Rmd 
	Rscript -e "rmarkdown::render('index.Rmd', output_format = rmarkdown::github_document())"

clean: 
	rm -f index.md index.pdf README.md
