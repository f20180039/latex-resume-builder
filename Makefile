# LaTeX Resume Builder
# Uses XeLaTeX for font support and Unicode compatibility

LATEX = xelatex
LATEX_FLAGS = -interaction=nonstopmode

.PHONY: all clean cleanall variants swe data help

# Default target: build main resume
all: resume.pdf

# Build all variants
variants: swe data

# Build main resume
resume.pdf: resume.tex config/*.tex sections/*.tex
	@echo "Building resume.pdf..."
	@$(LATEX) $(LATEX_FLAGS) resume.tex > /dev/null 2>&1 || true
	@if [ -f resume.pdf ]; then \
		echo "✓ Built resume.pdf"; \
	else \
		echo "✗ Build failed"; \
		cat resume.log; \
		exit 1; \
	fi

# Build Software Engineering variant
swe: variants/resume-swe.pdf

variants/resume-swe.pdf: variants/resume-swe.tex config/*.tex sections/*.tex
	@echo "Building Software Engineering variant..."
	@cd variants && $(LATEX) $(LATEX_FLAGS) resume-swe.tex > /dev/null 2>&1 || true
	@if [ -f variants/resume-swe.pdf ]; then \
		echo "✓ Built variants/resume-swe.pdf"; \
	else \
		echo "✗ Build failed"; \
		[ -f variants/resume-swe.log ] && cat variants/resume-swe.log; \
		exit 1; \
	fi

# Build Data Science variant
data: variants/resume-data.pdf

variants/resume-data.pdf: variants/resume-data.tex config/*.tex sections/*.tex
	@echo "Building Data Science variant..."
	@cd variants && $(LATEX) $(LATEX_FLAGS) resume-data.tex > /dev/null 2>&1 || true
	@if [ -f variants/resume-data.pdf ]; then \
		echo "✓ Built variants/resume-data.pdf"; \
	else \
		echo "✗ Build failed"; \
		[ -f variants/resume-data.log ] && cat variants/resume-data.log; \
		exit 1; \
	fi

# Clean build artifacts
clean:
	@rm -f *.aux *.log *.out *.synctex.gz *.synctex\(busy\) missfont.log
	@rm -f variants/*.aux variants/*.log variants/*.out variants/*.synctex.gz variants/*.synctex\(busy\)
	@echo "✓ Cleaned build artifacts"

# Clean everything including PDFs
cleanall: clean
	@rm -f *.pdf variants/*.pdf
	@echo "✓ Removed all generated files"

# Help target
help:
	@echo "LaTeX Resume Build System"
	@echo ""
	@echo "Usage:"
	@echo "  make           - Build main resume.pdf"
	@echo "  make variants  - Build all resume variants (SWE, Data Science)"
	@echo "  make swe       - Build Software Engineering variant"
	@echo "  make data      - Build Data Science variant"
	@echo "  make clean     - Remove build artifacts (.aux, .log, etc.)"
	@echo "  make cleanall  - Remove all generated files including PDFs"
	@echo "  make help      - Show this help message"
	@echo ""
	@echo "File structure:"
	@echo "  resume.tex        - Main resume document"
	@echo "  config/           - Configuration files (profile, style, commands)"
	@echo "  sections/         - Content sections"
	@echo "  variants/         - Resume variants for different roles"
