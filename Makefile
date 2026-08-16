# LaTeX Resume Builder
# Uses XeLaTeX for font support and Unicode compatibility

TINYTEX_BIN = $(HOME)/Library/TinyTeX/bin/universal-darwin
LATEX = $(if $(wildcard $(TINYTEX_BIN)/xelatex),$(TINYTEX_BIN)/xelatex,xelatex)
LATEX_FLAGS = -interaction=nonstopmode
FULL_NAME_SAFE = Anshuman_Singh
YEARS_OF_EXPERIENCE = 4
ROLE_ABBREV = FE
FE_JOBNAME = $(FULL_NAME_SAFE)_$(YEARS_OF_EXPERIENCE)$(ROLE_ABBREV)
FE_OUTPUT = $(FE_JOBNAME).pdf
COMMON_DEPS = config/*.tex sections/*.tex

.PHONY: all resume clean cleanall variants single-col help

# Default target: build frontend resume
all: $(FE_OUTPUT)

# Alias for the main frontend resume
resume: $(FE_OUTPUT)

# Build all variants
variants: single-col

# Build main frontend resume with role-specific output filename
$(FE_OUTPUT): resume.tex $(COMMON_DEPS)
	@echo "Building $(FE_OUTPUT)..."
	@if ! command -v $(LATEX) > /dev/null 2>&1; then \
		echo "✗ $(LATEX) not found. Install XeLaTeX to build PDFs."; \
		exit 1; \
	fi
	@$(LATEX) $(LATEX_FLAGS) -jobname=$(FE_JOBNAME) resume.tex > /dev/null 2>&1 || true
	@$(LATEX) $(LATEX_FLAGS) -jobname=$(FE_JOBNAME) resume.tex > /dev/null 2>&1 || true
	@if [ -f $(FE_OUTPUT) ]; then \
		echo "✓ Built $(FE_OUTPUT)"; \
	else \
		echo "✗ Build failed"; \
		[ -f $(FE_JOBNAME).log ] && cat $(FE_JOBNAME).log; \
		exit 1; \
	fi

# Compatibility target for older workflows
resume.pdf: $(FE_OUTPUT)
	@cp $(FE_OUTPUT) resume.pdf
	@echo "✓ Copied $(FE_OUTPUT) to resume.pdf"

# Build Single Column variant
single-col: variants/resume-single-col.pdf

variants/resume-single-col.pdf: variants/resume-single-col.tex $(COMMON_DEPS)
	@echo "Building Single Column variant..."
	@if ! command -v $(LATEX) > /dev/null 2>&1; then \
		echo "✗ $(LATEX) not found. Install XeLaTeX to build PDFs."; \
		exit 1; \
	fi
	@cd variants && $(LATEX) $(LATEX_FLAGS) resume-single-col.tex > /dev/null 2>&1 || true
	@cd variants && $(LATEX) $(LATEX_FLAGS) resume-single-col.tex > /dev/null 2>&1 || true
	@if [ -f variants/resume-single-col.pdf ]; then \
		echo "✓ Built variants/resume-single-col.pdf"; \
	else \
		echo "✗ Build failed"; \
		[ -f variants/resume-single-col.log ] && cat variants/resume-single-col.log; \
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
	@echo "  make             - Build $(FE_OUTPUT)"
	@echo "  make resume      - Build $(FE_OUTPUT)"
	@echo "  make resume.pdf  - Build $(FE_OUTPUT) and copy it to resume.pdf"
	@echo "  make variants    - Build all resume variants (Single Column)"
	@echo "  make single-col  - Build Single Column variant"
	@echo "  make clean       - Remove build artifacts (.aux, .log, etc.)"
	@echo "  make cleanall    - Remove all generated files including PDFs"
	@echo "  make help        - Show this help message"
	@echo ""
	@echo "File structure:"
	@echo "  resume.tex        - Main resume document"
	@echo "  config/           - Configuration files (profile, style, commands)"
	@echo "  sections/         - Content sections"
	@echo "  variants/         - Resume variants for different roles"
