# Makefile for IA4: Data Analysis Pipeline Practice

RAW_TXT = data/isles.txt data/abyss.txt data/last.txt data/sierra.txt

DAT_FILES = results/isles.dat results/abyss.dat results/last.dat results/sierra.dat

PLOT_FILES = results/figure/isles.png results/figure/abyss.png results/figure/last.png results/figure/sierra.png

REPORT = report/count_report.html

all: $(REPORT)

# 1. Create .dat files
results/%.dat: scripts/wordcount.py data/%.txt
	python scripts/wordcount.py --input_file=data/$*.txt --output_file=results/$*.dat

# 2. Create plots
results/figure/%.png: scripts/plotcount.py results/%.dat
	python scripts/plotcount.py --input_file=results/$*.dat --output_file=results/figure/$*.png

# 3. Render Quarto report
$(REPORT): report/count_report.qmd $(PLOT_FILES)
	quarto render report/count_report.qmd

# Clean up
clean:
	rm -f results/*.dat
	rm -f results/figure/*.png
	rm -f report/*.html

.PHONY: all clean
