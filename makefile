all:
	Rscript -e "rmarkdown::render('index.Rmd')"

index.pdf: index.Rmd 
	Rscript -e "rmarkdown::render('index.Rmd')"


index.md: index.Rmd 
	Rscript -e "rmarkdown::render('index.Rmd', output_format = rmarkdown::github_document())"

clean: 
	rm -f index.md index.pdf
