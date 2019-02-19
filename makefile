all:
	Rscript -e "rmarkdown::render('README.Rmd')"

README.pdf: README.Rmd 
	Rscript -e "rmarkdown::render('README.Rmd')"


README.md: README.Rmd 
	Rscript -e "rmarkdown::render('README.Rmd', output_format = rmarkdown::github_document())"

clean: 
	rm -f README.md README.pdf
