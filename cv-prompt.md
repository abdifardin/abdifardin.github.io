### Prompt to Generate Tailored Resume for Job Application

**Goal:** To create a tailored resume using pure Markdown formatting optimized for the specific job position.

**Context:**
My base resume is at `@resume.md`, and project details are in the `_posts/` directory. Use these as source materials to create a targeted resume based on the job requirements.

**Instructions:**

### Resume Generation Process

1.  **Analyze Job Description:** Carefully read the provided job description to identify:
    - Job description
    - Required years of experience
    - Specific technologies
    - Key skills and technical requirements
    - Industry knowledge or domain expertise needed
    - Preferred qualifications and experience types

2.  **Create Pure Markdown CV:** Create `cv-fardin-[company_name].md` using **ONLY** standard Markdown:
    - Use `#` for main heading (name)
    - Use `##` for section headers (EXPERIENCE, EDUCATION, etc.)
    - Use `###` for company names
    - Use `**bold**` for job titles and emphasis
    - Use standard bullet points with `-`
    - NO HTML tags, NO inline styles, NO div elements
    - Clean, simple Markdown structure only

3.  **Header Structure (Pure Markdown):**
    ```markdown
    # Fardin Abdi
    ## [Job Title from Job Description]
    **London** | abdi.fakhruddin@gmail.com | +447599128187
    **[Key Technologies and Skills from Job Requirements]**
    ```

4.  **Profile Summary:** Add 2-3 lines after header highlighting:
    - Relevant experience that matches job requirements
    - Domain knowledge and industry expertise as needed
    - Technical skills and achievements that align with the role
    - Leadership or scaling experience if applicable

5.  **Experience Section Tailoring:**
    - **Keep original job order** but if needed rewrite bullet based on the posts available in the `_posts/` directory to emphasize:
    - Technologies and skills mentioned in job requirements
    - Industry-specific experience that matches the role
    - Quantified achievements and metrics relevant to the position
    - Leadership and scaling experience if applicable
    - Performance optimization and technical achievements
    - Development processes and methodologies mentioned in job description

6.  **Technology Keywords:** Prioritize technologies from job description throughout:
    - Extract key technologies from job requirements
    - Highlight relevant programming languages and frameworks
    - Emphasize tools and platforms mentioned in the job posting
    - Include industry-specific knowledge areas
    - Focus on development methodologies and practices required

7.  **Project Links:** Use absolute URLs: `https://fakhruddin.info/[project-slug]/`

8.  **Featured Projects:** Select projects most relevant to job requirements:
    - Review all projects in `_posts/` directory where `projects: true`
    - Match project technologies and domains to job requirements
    - Prioritize projects that demonstrate required skills and experience
    - Include projects with relevant metrics and achievements

9.  **Formatting Requirements:**
    - Pure Markdown only
    - No HTML tags or inline styles
    - Clean, readable structure
    - Professional and humble tone
    - Concrete achievements over buzzwords
    - Avoid orphaned words at line ends

10. **Domain-Specific Context:** Emphasize experience relevant to the job's industry:
    - Match technical experience to job domain (fintech, healthcare, e-commerce, etc.)
    - Highlight relevant data processing and visualization experience
    - Focus on applicable business logic and user experience
    - Include relevant compliance or security experience
    - Showcase understanding of industry-specific challenges

### Content Management and Pagination

11. **Page Distribution Formula (3-Page CV):**
    
    **Page 1 Content (Target: ~30-35 lines):**
    - Header + Profile Summary (~8 lines)
    - Experience section header (~1 line)
    - First 3 experiences: AGGA.AI, Huma, Softcode (~20-25 lines)
    - This ensures page 1 focuses on most recent and relevant roles
    
    **Page 2 Content (Target: ~25-30 lines):**
    - Box Advertising experience (~8-10 lines)
    - Harzaan experience (~10-12 lines with enhanced content)
    - Newroz Telecom experience (~8-10 lines with enhanced content)
    - Complete experiences without section breaks
    
    **Page 3 Content (Target: ~20 lines):**
    - Education section (~7 lines)
    - Awards & Certificates (~6 lines)
    - Featured Projects (~8 lines)

12. **Content Length Guidelines:**
    - **Recent experience entries (AGGA, Huma, Softcode)**: 3-5 bullet points each
    - **Mid-career experience (Box Advertising)**: 3-5 bullet points
    - **Key positions (Harzaan, Newroz)**: 6-8 bullet points each
    - **Bullet points**: Maximum 2 lines each to prevent orphaned text
    - **Project descriptions**: 1 line each with quantified metrics
    - **Section spacing**: Consistent spacing between sections

13. **Page Break Implementation:**
    - Add `<div style="page-break-before: always;"></div>` before Box Advertising section
    - Add `<div style="page-break-before: always;"></div>` before Education section
    - Ensure complete sections stay together on single pages
    - Never split experience entries across pages

14. **Content Optimization Rules:**
    - Trim bullet points to prevent single-word line endings
    - Prioritize quantified achievements over lengthy descriptions
    - Maintain professional tone while being concise
    - Focus on job-relevant content in each section
    - Adjust content length to fit pagination formula

### Example CV Structure

```markdown
# Fardin Abdi
## [Job Title from Job Description]
**London** | abdi.fakhruddin@gmail.com | +447599128187  
**[Key Technologies and Skills from Job Requirements]**

[Profile summary tailored to job requirements, highlighting relevant experience and domain knowledge.]

## EXPERIENCE (UK)

### AGGA.AI
**[Job Title]** | *[Location]* | [Dates]
- [3-5 bullet points for current role]
- [AI and builder technologies]
- [Innovation and technical achievements]

### Huma Therapeutics
**[Job Title]** | *[Location]* | [Dates]
- [3-5 bullet points for recent roles]
- [Technical achievements]
- [Industry-specific experience]

### Softcode Solution
**[Job Title]** | *[Location]* | [Dates]
- [3-5 bullet points for recent roles]
- [Leadership or scaling experience]
- [Development processes and methodologies]

<!-- PAGE 1 ENDS HERE (~30-35 lines) -->
<div style="page-break-before: always;"></div>

## EXPERIENCE (International)

### Box Advertising
**[Job Title]** | *[Location]* | [Dates]
- [3-5 bullet points for this role]
- [Platform development and VIP features]
- [Multi-language and ERP solutions]

### Harzaan
**[Job Title]** | *[Location]* | [Dates]
- [6-8 bullet points with enhanced content]
- [Cross-platform development achievements]
- [User growth metrics and technical optimization]
- [CI/CD and deployment automation]
- [Analytics and business intelligence]
- [Performance optimization results]
- [User experience improvements]
- [Technical architecture decisions]

### Allai Newroz Telecom
**[Job Title]** | *[Location]* | [Dates]
- [6-8 bullet points with enhanced content]
- [Investment and team management]
- [Large-scale system development]
- [Multi-platform coordination]
- [Technical leadership experience]
- [Training and hiring pipeline]
- [Cross-technology integration]

<!-- PAGE 2 ENDS HERE (~25-30 lines) -->
<div style="page-break-before: always;"></div>

## EDUCATION
### [University Name]
**[Degree]** | *[Location]* | [Dates]
- [Relevant academic achievements]
- [Technical skills and certifications]
- [Leadership or teaching experience]
- [Projects and research work]

## Awards & Certificates
- [Relevant certifications for the role]
- [Professional achievements and recognition]
- [Industry-specific qualifications]
- [Additional credentials]

## Featured Projects
- **[Project Name](https://fakhruddin.info/project/)** - [Description highlighting relevance to job]
- **[Project Name](https://fakhruddin.info/project/)** - [Technical achievements and metrics]
- **[Project Name](https://fakhruddin.info/project/)** - [Domain expertise and impact]

<!-- PAGE 3 ENDS HERE (~20 lines) -->
```

### Cover Letter Generation

15. **Ask for Cover Letter Input:** Ask the user for any key points, motivations, or specific experiences they want to include in the cover letter.

16. **Get Current Date:** Run the `date '+%d %B %Y'` command in the terminal to get the current date.

17. **Create Markdown Cover Letter:** Create a file named `cover-letter-[company_name].md`. Draft a professional and concise cover letter based on the user's input and the job description. Replace the `[Date]` placeholder with the date from the previous step.

### Finalization and Archiving

**IMPORTANT:** All file operations must happen within the project workspace first. Only at the final step should files be moved to the destination directory.

18. **Generate Resume PDF:** Run the command `md-to-pdf cv-fardin-[company_name].md`. This generates the PDF in the current directory. Do not add any stylesheet arguments.

19. **Generate Cover Letter PDF:** Run `md-to-pdf cover-letter-[company_name].md` to create the cover letter PDF.

20. **Create Job Info File:** Create a new file named `job-info-[company_name].md` in the current directory. Populate it with:
    - Company name and job title
    - Application date
    - The full job description
    - Key requirements extracted from the job description

21. **Generate Job Info PDF:** Run `md-to-pdf job-info-[company_name].md` to create the job info PDF.

22. **Create Destination Directory:** Run the command `mkdir -p ~/Documents/jobs/[company_name]`.

23. **Archive PDF Files:** Run a single `mv` command to move the generated PDF files (`cv-fardin-[company_name].pdf`, `cover-letter-[company_name].pdf`, and `job-info-[company_name].pdf`) to the `~/Documents/jobs/[company_name]/` directory.

24. **Verify:** After moving the files, run `ls -l ~/Documents/jobs/[company_name]/` to confirm that all files were moved successfully.

25. **Cleanup:** Remove the local markdown files (`cv-fardin-[company_name].md`, `cover-letter-[company_name].md`, `job-info-[company_name].md`).

---