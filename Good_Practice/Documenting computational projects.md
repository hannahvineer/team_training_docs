---
title: "Documenting computational projects"
subtitle: "Using Git, Github and RStudio"
author: Hannah Vineer
date: June 13, 2024
output: md_document:
    variant: markdown_github
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Why the **** did I do that?

How many times have you revisited some R code, and cursed under your breath "why the **** did I do that?" 

How many versions of an R script do you have with various prefixes/suffixes along the lines of "R_code_v32_final_final_FINAL_REALFINAL.r"? 

And if you're really honest, how often have you guessed which is the latest version based on the date it was last modified? 

**Surely there's a better way?**

Physical lab notebooks are standard practice but computational lab notebooks lag far behind. As a result, we end up with a medley of versions of scripts, with no clear idea how each differs from the last and which should be used, collaborators waste time working on old versions of code/models, and when the time comes to write up the research, nobody can remember why decisions were made. Using Git to document and version control your computational research can solve the majority of these issues. 

## What is Git?

Git is software which allows you to:

1. Document the development of your project, including changes and decisions made.
2. "Branch" out to explore/experiment with different solutions.
3. Take snapshots of the project ("commits") and revisit previous versions of code.

Linking with a "remote" such as Github allows you to:

4. Collaborate with others.
5. Back up your work.
6. Access your work from different locations.
7. Share your work with others.

Watch this excellent introduction by Alice Bartlett:
(If the embedded video below doesn't work, follow this link or search "Git for Humans – Alice Bartlett at UX Brighton 2016" https://www.youtube.com/watch?v=eWxxfttcMts)

<iframe width="560" height="315" src="https://www.youtube.com/embed/eWxxfttcMts?si=KgxmNvUhSwGF7qTs" data-external= "1" ></iframe>

## Using Git for your computational project

When you begin a project, I'd recommend:

1. Setting up a repository for the project on Github.
2. Setting up an RStudio project linked to the repository (assuming you're using R).
3. Creating a READ ME file for the repository which outlines the aims of the project, proposed approach, and any other relevant information.

At intervals throughout the project I'd also recommend:

4. Creating markdown documents demonstrating and describing the implementation of scripts held within the repo. 

While implementing Git as part of your computational project provides documentation and version control, it does not provide researchers picking up the project for the first time with much information about the project nor how to implement the files contained within the repo (such as a new team member, especially when the person who wrote the files in the repo is absent). Therefore, creating a READ ME file in the repo, and supplementing this with markdown documents at key intervals, can help bridge this gap.

### Set up a project

To get up and running with points 1 and 2 above, you can follow this quick start guide. For more detailed instructions, and to learn more about using Git with Github and RStudio, check out the many online resources, including https://rfortherestofus.com/2021/02/how-to-use-git-github-with-r and the "Happy Git with R" online book: https://happygitwithr.com

1. Download Git (if necessary, see Happy Git with R book linked above). You can check whether Git is already/correctly installed by running "git --version" in the RStudio Terminal tab.

2. Sign up to Github https://github.com

3. Create a Personal Access Token for your GitHub. The following code will take you to Github to generate your PAT. You may want to save this in your password manager as you'll never be able to see this again. 

4. Link RStudio with your Github.
You will be asked to enter your PAT.
```{r, eval = F, echo = T}
require(usethis)
require(gitcreds)
usethis::create_github_token()
gitcreds::gitcreds_set()
```
Now RStudio and Github are connected!

5. Create a project repository in Github and copy the repo URL.

6. Create a new RStudio project.
Select "Version control" and enter the repo URL.
Choose where you want files to be stored locally (remember this is where you will be working with files in between pull/push to the repo.

### Using Git in RStudio

Once you have your Github linked to RStudio and have an RStudio project linked to the project repo on Github, you can begin to work with scripts.

Try creating a new script and naming it "test.R". Write something in the file. Now find the "Git" tab in RStudio, and hit the "Commit" button. This will "commit" your changes, taking a snapshot of all of the files at that time. Check your Github repository - you'll see that "test.R" has not yet appeared in the repo. Go back to the Git tab in RStudio and hit "Push" - this uploads the files to the repo, and "test.R" should now appear in your Github repo online. 

**Workflow:**

If you're working alone, you may wish to work with the local files and just commit and push changes to your Github repo at key intervals.

If you're working collaboratively, it's a good idea to "Pull" from the repo before working on scripts, to ensure you're working on the latest version. 

In both cases, don't forget to document the development of your code at the time you commit changes. 

Also, use RMarkdown (https://rmarkdown.rstudio.com) when appropriate to document and demonstrate your working code, e.g. for progress meetings, and at key project milestones.  
