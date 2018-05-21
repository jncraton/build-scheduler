SRC = readme.pmd

all: $(SRC).html

$(SRC).html: $(SRC).pmd
	pweave --format=md2html $(SRC).pmd
	# Hack to remove padding from first line of code blocks
	sed -i -e "s/padding: 2px 4px//g" $(SRC).html

$(SRC).md: $(SRC).pmd
	pweave --format=pandoc $(SRC).pmd

$(SRC).py: $(SRC).pmd
	ptangle $(SRC).pmd

$(SRC).pdf: $(SRC).html
	chromium-browser --headless --print-to-pdf=$(SRC).pdf $(SRC).html
	
run: $(SRC).py
	python3 $(SRC).py

clean:
	rm -f $(SRC).pdf $(SRC).md $(SRC).py
	rm -rf figures
	rm -rf __pycache__