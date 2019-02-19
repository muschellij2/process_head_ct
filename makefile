all: index.pdf README.md index.md

index.pdf: index.Rmd 
	Rscript -e "rmarkdown::render('index.Rmd')"

README.md: README.Rmd 
	Rscript -e "rmarkdown::render('README.Rmd')"

index.md: index.Rmd 
	Rscript -e "rmarkdown::render('index.Rmd', output_format = rmarkdown::github_document())"

clean: 
	rm -f index.md index.pdf README.md
