# LaTeX Resume Builder

A modular XeLaTeX resume template with clear section-owned files and role-specific variants. The default build generates `Anshuman_Singh_4FE.pdf`.

## Structure

```text
.
|-- resume.tex                 # Main frontend resume entrypoint
|-- config/
|   |-- profile.tex            # Personal information and output metadata
|   |-- style.tex              # Packages, margins, spacing
|   `-- commands.tex           # Shared LaTeX commands
|-- sections/
|   |-- experience.tex         # Work experience
|   |-- education.tex          # Education
|   |-- projects.tex           # Selected projects
|   |-- achievements.tex       # Achievements
|   |-- skills.tex             # Skills
|   |-- courses.tex            # Relevant coursework
|   |-- interests.tex          # Interests
|   `-- programming.tex        # Programming accolades
|-- variants/                  # Alternate resume entrypoints
|-- legacy/                    # Archived old template files
|-- fonts/                     # Local fonts retained for compatibility
|-- media/                     # Images and assets
`-- Makefile                   # Build automation
```

## Main File

The main resume entrypoint is `resume.tex`.

Use this file to control the order of sections included in the default two-column resume:

```latex
\input{sections/experience.tex}
\input{sections/education.tex}
\input{sections/achievements.tex}
\input{sections/projects.tex}
\input{sections/skills.tex}
```

## Build

TinyTeX is installed at `~/Library/TinyTeX`. The Makefile automatically uses that XeLaTeX binary when present.

From the project root:

```bash
make             # Build Anshuman_Singh_4FE.pdf
make resume.pdf  # Build the named PDF and copy it to resume.pdf
make variants    # Build SWE, data, and single-column variants
make clean       # Remove LaTeX artifacts
make cleanall    # Remove artifacts and generated PDFs
```

## Editing

- Edit `config/profile.tex` for personal data, portfolio link, and output metadata.
- Edit `sections/experience.tex`, `sections/projects.tex`, etc. for resume content.
- Keep the main resume to one page by adjusting the section order in `resume.tex` or trimming bullets inside section files.

## Current Additions

- Candidate name links to the portfolio: `https://f20180039.github.io/anshuman-singh/`.
- Portfolio Website is included as a project.
- Exploding Production Game is included as a project: `https://exploding-production.onrender.com`.
- Multiplayer Game Hub is included as a project: `https://multiplayer-frontend-x0cb.onrender.com`.
- Header/contact fields use readable text links with FontAwesome icons.
- Hidden ATS keyword text is centralized in `sections/ats-keywords.tex` and rendered with zero layout height.
- Rupee glyphs were replaced with `INR` to avoid missing-character warnings.
