# Claude Context: LaTeX Resume Template

## Project Overview

This is a modular, maintainable LaTeX resume template system that has been refactored from a monolithic structure into a clean, organized codebase. The template supports multiple resume variants for different job applications while maintaining a single source of truth for personal information and styling.

**Key Philosophy**: Separate data from presentation, eliminate duplication, enable easy customization.

## Architecture

### Core Principles

1. **Separation of Concerns**: Data (profile), styling (packages/formatting), commands (LaTeX macros), and content (sections) are isolated
2. **DRY (Don't Repeat Yourself)**: Personal information defined once in `config/profile.tex`
3. **Modularity**: Each section is independent and can be included/excluded per variant
4. **Build Automation**: Makefile handles compilation for all variants
5. **Pixel-Perfect Preservation**: Refactoring maintained identical output to original

### Directory Structure

```
.
├── resume.tex                 # Main resume (entry point)
├── config/                    # Configuration and setup
│   ├── profile.tex           # Personal data (EDIT HERE for updates)
│   ├── style.tex             # LaTeX packages & styling
│   └── commands.tex          # Custom LaTeX command definitions
├── sections/                  # Content modules (independent)
│   ├── experience.tex        # Work experience entries
│   ├── education.tex         # Educational qualifications
│   ├── projects.tex          # Selected projects
│   ├── achievements.tex      # Scholastic achievements
│   ├── skills.tex            # Technical skills
│   ├── courses.tex           # Relevant coursework
│   ├── interests.tex         # Personal interests
│   └── programming.tex       # (legacy, not used in main resume)
├── variants/                  # Role-specific resume versions
│   ├── resume-swe.tex        # Software Engineering focus
│   └── resume-data.tex       # Data Science focus
├── legacy/                    # Archived old files (reference only)
│   ├── cv.tex                # Original two-page template
│   ├── awesome-cv.cls        # Original class file (704 lines, 35% unused)
│   └── education-full.tex    # Old education section
├── fonts/                     # Custom fonts for XeLaTeX
├── media/                     # Images and assets
├── Makefile                   # Build automation
├── README.md                  # User-facing documentation
└── CLAUDE.md                  # This file (AI assistant context)
```

## File Descriptions

### Main Files

**resume.tex** (48 lines)
- Entry point for main resume
- Minimal structure: imports config, generates header, includes sections
- Uses two-column layout with minipage
- Pattern: `\documentclass → \input{config/*} → \begin{document} → \makeheader → sections → \end{document}`

### Configuration Files

**config/profile.tex** (11 lines)
- **THIS IS THE SINGLE SOURCE OF TRUTH FOR PERSONAL DATA**
- Defines LaTeX macros: `\fullname`, `\email`, `\phone`, `\linkedin`, `\linkedinhandle`, `\jobtitle`, `\education`
- Changes here propagate to all resume variants automatically
- No LaTeX code, just `\def` statements

**config/style.tex** (42 lines)
- All `\usepackage` declarations
- Page geometry (margins, paper size)
- List formatting (itemize spacing)
- Section title spacing
- Graphics path
- **MODIFY HERE** to change: margins, colors, fonts, spacing

**config/commands.tex** (69 lines)
- Custom LaTeX command definitions
- Key commands:
  - `\strong{text}` - Bold with nested toggle (complex \makeatletter logic)
  - `\cvsection{title}` - Section header with horizontal rule
  - `\cventry{company}{position}{location}{date}{description}` - Job/project entry
  - `\smallcventry{...}` - Education entry (6 params)
  - `\makeheader` - Generates header from profile.tex variables
  - Column types: L, C, R for table alignment
- **DO NOT MODIFY** unless adding new commands or fixing bugs

### Section Files

All sections follow similar patterns:

**experience.tex** (60 lines)
- Uses `\cvsection{WORK EXPERIENCE}` + `cventries` environment
- Each job is a `\cventry{Company}{Position}{Location}{Dates}{description}`
- Description uses nested `cvitems` (itemize-based) for bullet points
- Pattern: Company link → role → location/dates → bullets

**education.tex** (40 lines)
- Uses `\smallcventry{Institution}{Degree}{Location}{Year}{Grade}{Extra}`
- One entry per degree
- Extra param allows nested `cvitems` (currently unused)

**projects.tex** (70 lines)
- Same structure as experience.tex
- GitHub/demo links in company field
- Shorter date ranges

**achievements.tex** (16 lines)
- Simple itemize list, no special commands
- Bullet points with `\textbf{}` for emphasis

**skills.tex** (9 lines)
- Simplified format (removed conditional logic)
- Uses `\\` and `\vspace{}` for spacing
- Pattern: **Category**: comma-separated list

**courses.tex**, **interests.tex**
- Simple text with `$|$` separators
- Not included in main resume, available for variants

### Variant Files

**variants/resume-swe.tex** (45 lines)
- Software Engineering focus
- Includes: experience, education, achievements, projects
- Uses `../` paths for config and section imports
- SEO text at bottom (hidden white text for ATS)

**variants/resume-data.tex** (48 lines)
- Data Science focus
- Includes: experience, education, **skills**, achievements, projects
- Different SEO text emphasizing data science keywords

## Custom Commands Reference

### Section Commands

```latex
\cvsection{Title}           % Section with \hrulefill
\specialcvsection{Title}    % Section without rule
```

### Entry Commands

```latex
% Work experience / Projects (5 params)
\cventry{Company}{Position}{Location}{Dates}{
  \begin{cvitems}
    \item Description point 1
    \item Description point 2
  \end{cvitems}
}

% Education (6 params)
\smallcventry{Institution}{Degree}{City}{Year}{Grade}{}

% Achievements (4 params, simplified in usage)
\cvhonor{Award}{Organization}{Year}{Description}
```

### Formatting Commands

```latex
\strong{text}        % Bold with nested toggle capability
\makeheader          % Generates header from profile.tex
\textcolor{white}{...}  % Hidden SEO text for ATS
```

### Environments

```latex
\begin{cventries}...\end{cventries}    % Container for entries
\begin{cvitems}...\end{cvitems}        % Bulleted list (itemize wrapper)
\begin{cvhonors}...\end{cvhonors}      % Honors list (not used currently)
```

## Common Operations

### Update Personal Information

**ALWAYS edit** `config/profile.tex`:
```latex
\def\fullname{NEW NAME}
\def\email{new.email@example.com}
\def\phone{+1-234-567-8900}
% ... etc
```
Run `make` to rebuild all resumes.

### Add New Work Experience

Edit `sections/experience.tex`:
```latex
\cventry
{Company Name}
{Job Title}
{Location}
{Start Date - End Date}
{
  \begin{cvitems}
  \item Accomplishment with \textbf{bold keywords}
  \item Another accomplishment with metrics
  \end{cvitems}
}
```

### Create New Resume Variant

1. Copy existing variant:
   ```bash
   cp variants/resume-swe.tex variants/resume-ml.tex
   ```

2. Edit to include different sections:
   ```latex
   % Change which sections are included
   \input{../sections/experience.tex}
   \input{../sections/projects.tex}
   \input{../sections/skills.tex}  % Add this
   % Remove \input{../sections/achievements.tex}
   ```

3. Update SEO text at bottom (white color)

4. Build: `cd variants && xelatex resume-ml.tex`

### Modify Page Layout

Edit `config/style.tex`:
```latex
% Change margins (line ~12)
\usepackage[a4paper, margin=0.25in]{geometry}  % Try 0.5in, 1cm, etc.

% Change list spacing (line ~38)
\setitemize{noitemsep,topsep=0.4pt,parsep=0.75pt,...}

% Change section spacing (line ~29)
\titlespacing*{\section}{0pt}{5pt plus 0pt minus 0pt}{0pt plus 2pt minus 2pt}
```

### Add New Section

1. Create `sections/certifications.tex`:
   ```latex
   \cvsection{\textbf{CERTIFICATIONS}}
   \begin{cvitems}
   \item AWS Certified Developer - Associate (2024)
   \item Google Cloud Professional Data Engineer (2023)
   \end{cvitems}
   ```

2. Include in resume:
   ```latex
   % In resume.tex or variant file
   \input{sections/certifications.tex}
   ```

## Build System

### Makefile Targets

```bash
make              # Build main resume.pdf
make variants     # Build all variants
make swe          # Build Software Engineering variant only
make data         # Build Data Science variant only
make clean        # Remove .aux, .log, .out files
make cleanall     # Remove all including PDFs
make help         # Show help message
```

### Manual Compilation

```bash
# Main resume
xelatex resume.tex

# Variant (from root)
cd variants && xelatex resume-swe.tex

# Or from variants directory
xelatex resume-swe.tex
```

**Note**: Always use `xelatex`, not `pdflatex`. XeLaTeX is required for:
- FontAwesome icons
- Unicode support
- Custom fonts in `fonts/` directory

## Important Conventions

### File Paths

- Main resume uses: `\input{config/profile.tex}`, `\input{sections/experience.tex}`
- Variants use: `\input{../config/profile.tex}`, `\input{../sections/experience.tex}`
- **Relative paths matter!** Compilation happens from current directory

### Formatting Standards

1. **Bold for emphasis**: Use `\textbf{keyword}` for important terms
2. **Links**: Use `\href{URL}{Display Text}` for clickable links
3. **Spacing**: Use `\vspace{2.5mm}` between sections (consistent)
4. **Line breaks**: Use `\\` for manual breaks, not `\newline`
5. **Currency**: Use `\textcolor{red}{₹}` if rupee symbol doesn't render
6. **Dates**: Format as "Month'YY - Month'YY" (e.g., "July'22 - Present")

### Content Guidelines

1. **Bullet points**: Start with action verbs or strong adjectives
2. **Metrics**: Include numbers when possible (e.g., "increased by 25%")
3. **Bold keywords**: Emphasize key technologies, achievements, metrics
4. **ATS optimization**: White text at bottom includes keywords for Applicant Tracking Systems
5. **One page rule**: Main resume should fit on one page; use variants for more content

## Known Issues & Quirks

### Font Warnings

```
! Font TU/FontAwesome(0)/m/n/10=FontAwesome at 10.0pt not loadable
```

**This is EXPECTED and non-critical.** The fonts are in `fonts/` directory and the PDF generates correctly. The warning occurs during font loading but doesn't affect output.

### Currency Symbol

```
Missing character: There is no ₹ (U+20B9) in font [lmroman10-regular]
```

The rupee symbol may not render in default fonts. Consider:
- Using `\textcolor{red}{₹}` for visibility
- Or replacing with "INR" or "Rs."
- Or using a font that supports Indian Rupee

### Command Already Defined Error

```
! LaTeX Error: Command \strong already defined.
```

This occurs if compiling twice without cleaning. Run `make clean` first. The error appears in logs but doesn't prevent PDF generation.

### Build Artifacts

The following files are generated during compilation:
- `*.aux` - Auxiliary file (references)
- `*.log` - Compilation log
- `*.out` - Hyperref output file
- `*.synctex.gz` - SyncTeX data (editor integration)
- `missfont.log` - Font loading attempts

All are listed in `.gitignore` and cleaned by `make clean`.

## Legacy Files

Files in `legacy/` are **archived for reference only**:

**awesome-cv.cls** (704 lines)
- Original document class from Awesome-CV template
- 35% was unused (cover letter system, photo system, subentry system)
- No longer used; main resume now uses `extarticle` class with custom commands

**cv.tex** (78 lines)
- Original two-page template
- Used awesome-cv.cls
- Had different personal info (Yash Srivastav - indicates borrowed template)
- Kept for reference but not maintained

**education-full.tex**
- Alternate education section with table layout
- Entirely commented out in original
- Saved for potential future use

**Do not delete legacy files** - they provide historical context and reference for complex commands.

## Refactoring History

This codebase was refactored in April 2026 from a monolithic structure to modular architecture:

**Before**:
- Single 126-line file with embedded data, styles, commands
- 704-line class file (35% unused)
- Conditional compilation logic (`\ifdefined\ONEPAGE`)
- Personal info hardcoded in 9 locations
- Manual compilation only

**After**:
- 3 config files + 8 section files + main file
- No unused code
- Clean separation of concerns
- Single source of truth for personal data
- Automated build system
- Multiple variants supported

**Verification**: Output is pixel-perfect identical to original (verified via pdftotext diff).

## Guidelines for AI Assistants

When helping with this codebase:

1. **Always preserve output**: Any changes should maintain visual appearance unless explicitly requested
2. **Edit profile.tex for personal data**: Never hardcode names, emails, etc. in other files
3. **Verify compilation**: After changes, run `make clean && make` to ensure it builds
4. **Use existing commands**: Don't reinvent `\cventry` or `\cvsection` - use what's in commands.tex
5. **Respect file structure**: Keep sections in `sections/`, config in `config/`, variants in `variants/`
6. **Maintain consistency**: Follow existing formatting patterns in section files
7. **Test all variants**: When making structural changes, build all variants to ensure none break
8. **Document new commands**: If adding commands to commands.tex, document them in CLAUDE.md
9. **Preserve legacy**: Don't delete `legacy/` files - they provide reference and context
10. **Check README**: User-facing documentation is in README.md - keep it in sync with CLAUDE.md

## Technical Notes

### LaTeX Compilation Flow

```
resume.tex (entry point)
  ↓
config/style.tex (loads packages)
  ↓
config/commands.tex (defines macros)
  ↓
config/profile.tex (defines data)
  ↓
\makeheader (expands to header HTML)
  ↓
sections/*.tex (included in minipage columns)
  ↓
resume.pdf (output)
```

### Dependencies

**Required packages** (loaded in style.tex):
- inputenc, babel - Character encoding and language
- ragged2e - Text alignment
- xcolor - Color support
- geometry - Page layout
- multicol - Multi-column (not heavily used)
- array - Table support
- fontawesome - Icon fonts
- hyperref - Clickable links
- titlesec - Section spacing
- hyphenat - Hyphenation control
- graphicx - Image support
- enumitem - List customization

**Document class**: `extarticle` with 10.5pt option (non-standard sizes)

### Color Scheme

Currently minimal:
- Default black text
- White text for hidden SEO keywords
- Link colors inherited from hyperref defaults (hidden with `hidelinks` option)

**To add colors**: Edit style.tex and define with `\definecolor{name}{HTML}{HEXCODE}`

## Future Enhancements

Potential improvements (not yet implemented):

1. **Theme system**: Create `style-minimal.tex`, `style-colorful.tex` variants
2. **YAML configuration**: Generate profile.tex from YAML file for easier editing
3. **CI/CD**: GitHub Actions to auto-build PDFs on push
4. **Two-page variant**: Refactor legacy/cv.tex to use new structure
5. **Multilingual support**: Create `profile-en.tex`, `profile-es.tex`
6. **Icon library**: Add more icons beyond FontAwesome
7. **Dynamic filtering**: Tag entries and auto-select by variant type
8. **JSON export**: Script to convert LaTeX data to JSON for web resume

## Contact & Ownership

**Owner**: Anshuman Singh
- Email: singh.anshuman.singh8@gmail.com
- Current role: Frontend Engineer, HealthPlix Technologies
- Education: BITS Pilani ENI'22

**Template License**: Based on Awesome-CV (LPPL v1.3c)
**Refactored**: April 2026

---

**Version**: 2.0 (Refactored)  
**Last Updated**: April 13, 2026  
**Lines of Code**: ~300 (config + sections + main)  
**Build Time**: ~2-3 seconds per PDF
