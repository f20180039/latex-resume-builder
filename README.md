# LaTeX Resume Template

A modular, maintainable LaTeX resume template with support for multiple variants. Built with XeLaTeX for Unicode and font support.

## Features

- **Modular architecture**: Separate data, styling, and content
- **Easy customization**: Update personal information in one place
- **Multiple variants**: Create role-specific resumes (SWE, Data Science, etc.)
- **Build automation**: Makefile for easy compilation
- **Clean structure**: Well-organized files and directories

## File Structure

```
.
├── resume.tex                 # Main resume document
├── config/
│   ├── profile.tex           # Personal information (name, email, phone, etc.)
│   ├── style.tex             # Styling and package configuration
│   └── commands.tex          # Custom LaTeX commands
├── sections/
│   ├── experience.tex        # Work experience
│   ├── education.tex         # Educational qualifications
│   ├── projects.tex          # Selected projects
│   ├── achievements.tex      # Scholastic achievements
│   ├── skills.tex            # Technical skills
│   ├── courses.tex           # Relevant coursework
│   └── interests.tex         # Personal interests
├── variants/
│   ├── resume-swe.tex        # Software Engineering focus
│   └── resume-data.tex       # Data Science focus
├── legacy/
│   ├── cv.tex                # Old template (archived)
│   ├── awesome-cv.cls        # Old class file (archived)
│   └── education-full.tex    # Old education section (archived)
├── fonts/                     # Custom fonts for XeLaTeX
├── media/                     # Images and assets
├── Makefile                   # Build automation
└── README.md                  # This file
```

## Quick Start

### Prerequisites

- XeLaTeX (part of TeX Live or MikTeX)
- Make (optional, for build automation)

### Building the Resume

#### Using Make (recommended)

```bash
# Build main resume
make

# Build all variants
make variants

# Build specific variant
make swe      # Software Engineering variant
make data     # Data Science variant

# Clean build artifacts
make clean

# Clean everything including PDFs
make cleanall

# Show help
make help
```

#### Manual Compilation

```bash
# Build main resume
xelatex resume.tex

# Build variant
cd variants
xelatex resume-swe.tex
```

## Customization Guide

### Updating Personal Information

Edit `config/profile.tex`:

```latex
\def\fullname{Your Name}
\def\email{your.email@example.com}
\def\phone{+1-234-567-8900}
\def\linkedin{https://linkedin.com/in/yourprofile}
\def\linkedinhandle{Your Name}
\def\jobtitle{Your Current Role}
\def\education{Your University}
```

Changes will automatically apply to all resume variants.

### Customizing Styling

Edit `config/style.tex` to modify:
- Page margins
- Colors
- List formatting
- Section spacing
- Font settings

### Modifying Sections

Section files are in `sections/`. Each file is independent and can be edited separately.

### Creating New Variants

1. Copy an existing variant template:
   ```bash
   cp variants/resume-swe.tex variants/resume-ml.tex
   ```

2. Edit to include different sections or modify content emphasis

3. Build with `xelatex variants/resume-ml.tex`

## Custom Commands Reference

Defined in `config/commands.tex`:

- `\cvsection{Title}` - Section with horizontal rule
- `\cventry{Company}{Position}{Location}{Date}{Description}` - Experience/project entry
- `\smallcventry{...}` - Education entry
- `\cvhonor{Award}{Organization}{Year}{Description}` - Achievement entry
- `\makeheader` - Generate header from profile data

## Tips

1. Always update `config/profile.tex` first
2. Use Git to track changes
3. Keep main resume to 1 page
4. Build and check PDF after changes
5. Use variants for different job applications

## Troubleshooting

### Font Warnings

FontAwesome warnings are non-critical. PDF will still generate correctly.

### Compilation Errors

1. Check LaTeX syntax in modified files
2. Verify all `\input` paths are correct
3. Ensure braces `{}` are properly closed
4. Run `make clean` and try again

## License

Based on Awesome-CV template (archived in `legacy/`), licensed under LPPL v1.3c.

---

**Last Updated**: April 2026  
**Template Version**: 2.0 (Refactored)
