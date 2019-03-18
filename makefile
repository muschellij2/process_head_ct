all: index.pdf README.md index.md figures

index.pdf: index.Rmd 
	Rscript -e "rmarkdown::render('index.Rmd')"

README.md: README.Rmd 
	Rscript -e "rmarkdown::render('README.Rmd')"

figures: make_reg_image.R make_ss_image.R make_tilted_image.R plotting_overlays.R
	Rscript -e "source('make_reg_image.R')"
	Rscript -e "source('make_ss_image.R')"
	Rscript -e "source('make_tilted_image.R')"
	Rscript -e "source('plotting_overlays.R')"		

index.md: index.Rmd 
	Rscript -e "rmarkdown::render('index.Rmd', output_format = rmarkdown::github_document())"

clean: 
	rm -f index.md index.pdf README.md
