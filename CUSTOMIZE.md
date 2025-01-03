# 定制化

Here we will give you some tips on how to customize the website. One important thing to note is that **ALL** the changes you make should be done on the **main** branch of your repository. The `gh-pages` branch is automatically overwritten every time you make a change to the main branch.

## Project structure

The project is structured as follows, focusing on the main components that you will need to modify:

```txt
.
├── 📂 assets/: 包含网站展示用的资源文件
│   └── 📂 json/
    │   └── 📄 resume.json: JSON格式的简历 (https://jsonresume.org/)
├── 📂 _bibliography/
│   └── 📄 papers.bib: BibTeX格式的参考文献
├── 📄 _config.yml: 模板的配置文件
├── 📂 _data/: 包含模板使用的一些数据
│   ├── 📄 cv.yml: YAML格式的简历，当找不到 assets/json/resume.json 时使用
│   └── 📄 repositories.yml: YAML格式的用户和仓库信息
├── 📂 _includes/: 包含被引入到主HTML文件中的代码片段
│   └── 📄 news.liquid: 定义关于页面中新闻部分的布局
├── 📂 _layouts/: 包含可在 Markdown 文件的 frontmatter 中选择的布局
├── 📂 _news/: 将显示在关于页面新闻部分的新闻
├── 📂 _pages/: 包含网站的页面
|   └── 📄 404.md: 404页面（页面未找到）
├── 📂 _posts/: 包含博客文章
├── 📂 _projects/: 包含项目
└── 📂 _sass/: 包含定义网站样式的 SASS 文件
    ├── 📄 _base.scss: 网站的基础样式
    ├── 📄 _cv.scss: 简历页面的样式
    ├── 📄 _distill.scss: Distill 文章的样式
    ├── 📄 _layout.scss: 整体布局的样式
    ├── 📄 _themes.scss: 主题颜色和一些图标
    └── 📄 _variables.scss: SASS文件中使用的变量
```

## Configuration

The configuration file [\_config.yml](_config.yml) contains the main configuration of the website. Most of the settings is self-explanatory and we also tried to add as much comments as possible. If you have any questions, please check if it was not already answered in the [FAQ](FAQ.md).

> Note that the `url` and `baseurl` settings are used to generate the links of the website, as explained in the [install instructions](INSTALL.md).

All changes made to this file are only visible after you rebuild the website. That means that you need to run `bundle exec jekyll serve` again if you are running the website locally or push your changes to GitHub if you are using GitHub Pages. All other changes are visible immediately, you only need to refresh the page.

## Modifying the CV information

There are currently 2 different ways of generating the CV page content. The first one is by using a json file located in [assets/json/resume.json](assets/json/resume.json). It is a [known standard](https://jsonresume.org/) for creating a CV programmatically. The second one, currently used as a fallback when the json file is not found, is by using a yml file located in [\_data/cv.yml](_data/cv.yml). This was the original way of creating the CV page content and since it is more human readable than a json file we decided to keep it as an option.

What this means is, if there is no resume data defined in [\_config.yml](_config.yml) and loaded via a json file, it will load the contents of [\_data/cv.yml](_data/cv.yml). If you want to use the [\_data/cv.yml](_data/cv.yml) file as the source of your CV, you must delete the [assets/json/resume.json](assets/json/resume.json) file.

## Modifying the user and repository information

The user and repository information is defined in [\_data/repositories.yml](_data/repositories.yml). You can add as many users and repositories as you want. Both informations are used in the `repositories` section.

## Creating new pages

You can create new pages by adding new Markdown files in the [\_pages](_pages/) directory. The easiest way to do this is to copy an existing page and modify it. You can choose the layout of the page by changing the [layout](https://jekyllrb.com/docs/layouts/) attribute in the [frontmatter](https://jekyllrb.com/docs/front-matter/) of the Markdown file, and also the path to access it by changing the [permalink](https://jekyllrb.com/docs/permalinks/) attribute. You can also add new layouts in the [\_layouts](_layouts/) directory if you feel the need for it.

## 创建新的博客文章

要创建新的博客文章，你可以在 [\_posts](_posts/) 目录下添加一个新的 Markdown 文件。[文件名必须遵循](https://jekyllrb.com/docs/posts/#creating-posts)格式 `YYYY-MM-DD-title.md`。最简单的方法是复制一个现有的博客文章并修改它。注意某些博客文章在 [frontmatter](https://jekyllrb.com/docs/front-matter/) 中有可选字段，用于启用特定的行为或功能。

如果你想创建尚未准备好发布的博客文章，但想用 git 追踪它们，你可以创建一个 [\_drafts](https://jekyllrb.com/docs/posts/#drafts) 目录并将它们存储在那里。

## Creating new projects

You can create new projects by adding new Markdown files in the [\_projects](_projects/) directory. The easiest way to do this is to copy an existing project and modify it.

## Adding some news

You can add news in the about page by adding new Markdown files in the [\_news](_news/) directory. There are currently two types of news: inline news and news with a link. News with a link take you to a new page while inline news are displayed directly in the about page. The easiest way to create yours is to copy an existing news and modify it.

## Adding Collections

This Jekyll theme implements `collections` to let you break up your work into categories. The theme comes with two default collections: `news` and `projects`. Items from the `news` collection are automatically displayed on the home page. Items from the `projects` collection are displayed on a responsive grid on projects page.

You can easily create your own collections, apps, short stories, courses, or whatever your creative work is. To do this, edit the collections in the [\_config.yml](_config.yml) file, create a corresponding folder, and create a landing page for your collection, similar to [\_pages/projects.md](_pages/projects.md).

## Adding a new publication

To add publications create a new entry in the [\_bibliography/papers.bib](_bibliography/papers.bib) file. You can find the BibTeX entry of a publication in Google Scholar by clicking on the quotation marks below the publication title, then clicking on "BibTeX", or also in the conference page itself. By default, the publications will be sorted by year and the most recent will be displayed first. You can change this behavior and more in the `Jekyll Scholar` section in [\_config.yml](_config.yml) file.

You can add extra information to a publication, like a PDF file in the `assets/pdfs/` directory and add the path to the PDF file in the BibTeX entry with the `pdf` field. Some of the supported fields are: `abstract`, `altmetric`, `annotation`, `arxiv`, `bibtex_show`, `blog`, `code`, `dimensions`, `doi`, `eprint`, `html`, `isbn`, `pdf`, `pmid`, `poster`, `slides`, `supp`, `video`, and `website`.

### Author annotation

In publications, the author entry for yourself is identified by string array `scholar:last_name` and string array `scholar:first_name` in [\_config.yml](_config.yml). For example, if you have the following entry in your [\_config.yml](_config.yml):

```yaml
scholar:
  last_name: [Einstein]
  first_name: [Albert, A.]
```

If the entry matches one form of the last names and the first names, it will be underlined. Keep meta-information about your co-authors in [\_data/coauthors.yml](_data/coauthors.yml) and Jekyll will insert links to their webpages automatically. The co-author data format is as follows, with the last names lower cased and without accents as the key:

```yaml
"adams":
  - firstname: ["Edwin", "E.", "E. P.", "Edwin Plimpton"]
    url: https://en.wikipedia.org/wiki/Edwin_Plimpton_Adams

"podolsky":
  - firstname: ["Boris", "B.", "B. Y.", "Boris Yakovlevich"]
    url: https://en.wikipedia.org/wiki/Boris_Podolsky

"rosen":
  - firstname: ["Nathan", "N."]
    url: https://en.wikipedia.org/wiki/Nathan_Rosen

"bach":
  - firstname: ["Johann Sebastian", "J. S."]
    url: https://en.wikipedia.org/wiki/Johann_Sebastian_Bach

  - firstname: ["Carl Philipp Emanuel", "C. P. E."]
    url: https://en.wikipedia.org/wiki/Carl_Philipp_Emanuel_Bach
```

If the entry matches one of the combinations of the last names and the first names, it will be highlighted and linked to the url provided. Note that the keys **MUST BE** lower cased and **MUST NOT** contain accents. This is because the keys are used to match the last names in the BibTeX entries, considering possible variations.

### Buttons (through custom bibtex keywords)

There are several custom bibtex keywords that you can use to affect how the entries are displayed on the webpage:

- `abbr`: Adds an abbreviation to the left of the entry. You can add links to these by creating a venue.yaml-file in the \_data folder and adding entries that match.
- `abstract`: Adds an "Abs" button that expands a hidden text field when clicked to show the abstract text
- `altmetric`: Adds an [Altmetric](https://www.altmetric.com/) badge (Note: if DOI is provided just use `true`, otherwise only add the altmetric identifier here - the link is generated automatically)
- `annotation`: Adds a popover info message to the end of the author list that can potentially be used to clarify superscripts. HTML is allowed.
- `arxiv`: Adds a link to the Arxiv website (Note: only add the arxiv identifier here - the link is generated automatically)
- `bibtex_show`: Adds a "Bib" button that expands a hidden text field with the full bibliography entry
- `blog`: Adds a "Blog" button redirecting to the specified link
- `code`: Adds a "Code" button redirecting to the specified link
- `dimensions`: Adds a [Dimensions](https://www.dimensions.ai/) badge (Note: if DOI or PMID is provided just use `true`, otherwise only add the Dimensions' identifier here - the link is generated automatically)
- `html`: Inserts an "HTML" button redirecting to the user-specified link
- `pdf`: Adds a "PDF" button redirecting to a specified file (if a full link is not specified, the file will be assumed to be placed in the /assets/pdf/ directory)
- `poster`: Adds a "Poster" button redirecting to a specified file (if a full link is not specified, the file will be assumed to be placed in the /assets/pdf/ directory)
- `slides`: Adds a "Slides" button redirecting to a specified file (if a full link is not specified, the file will be assumed to be placed in the /assets/pdf/ directory)
- `supp`: Adds a "Supp" button to a specified file (if a full link is not specified, the file will be assumed to be placed in the /assets/pdf/ directory)
- `website`: Adds a "Website" button redirecting to the specified link

You can implement your own buttons by editing the [\_layouts/bib.liquid](_layouts/bib.liquid) file.

## Changing theme color

A variety of beautiful theme colors have been selected for you to choose from. The default is purple, but you can quickly change it by editing the `--global-theme-color` variable in the [\_sass/\_themes.scss](_sass/_themes.scss) file. Other color variables are listed there as well. The stock theme color options available can be found at [\_sass/\_variables.scss](_sass/_variables.scss). You can also add your own colors to this file assigning each a name for ease of use across the template.

## Adding social media information

You can add your social media links by adding the specified information at the `Social integration` section in the [\_config.yml](_config.yml) file. This information will appear at the bottom of the `About` page.

## Adding a newsletter

You can add a newsletter subscription form by adding the specified information at the `newsletter` section in the [\_config.yml](_config.yml) file. To set up a newsletter, you can use a service like [Loops.so](https://loops.so/), which is the current supported solution. Once you have set up your newsletter, you can add the form [endpoint](https://loops.so/docs/forms/custom-form) to the `endpoint` field in the `newsletter` section of the [\_config.yml](_config.yml) file.

Depending on your specified footer behavior, the sign up form either will appear at the bottom of the `About` page and at the bottom of blogposts if `related_posts` are enabled, or in the footer at the bottom of each page.

## Adding Token for Lighthouse Badger

To add secrets for [lighthouse-badger](https://github.com/alshedivat/al-folio/actions/workflows/lighthouse-badger.yml), create a [personal access token (PAT)](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-fine-grained-personal-access-token) and add it as a [secret](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions#creating-encrypted-secrets-for-a-repository) named `LIGHTHOUSE_BADGER_TOKEN` to your repository. The [lighthouse-badger documentation](https://github.com/MyActionWay/lighthouse-badger-workflows#lighthouse-badger-easyyml) specifies using an environment variable, but using it as a secret is more secure and appropriate for a PAT.

Also In case you face the error: "Input required and not supplied: token" in the Lighthouse Badger action, this solution resolves it.

### Personal Access Token (fine-grained) Permissions for Lighthouse Badger:

- **contents**: access: read and write
- **metadata**: access: read-only

Due to the necessary permissions (PAT and others mentioned above), it is recommended to use it as a secret rather than an environment variable.

## Customizing fonts, spacing, and more

You can customize the fonts, spacing, and more by editing [\_sass/\_base.scss](_sass/_base.scss). The easiest way to try in advance the changes is by using [chrome dev tools](https://developer.chrome.com/docs/devtools/css) or [firefox dev tools](https://firefox-source-docs.mozilla.org/devtools-user/page_inspector/how_to/examine_and_edit_css/index.html) how-tos, and [this tutorial](https://www.youtube.com/watch?v=l0sgiwJyEu4).

## Scheduled Posts

`al-folio` contains a workflow which automatically publishes all posts scheduled at a specific day, at the end of the day (23:30). By default the action is disabled, and to enable it you need to go to `.github/workflows/` and find the file called `schedule-posts.txt`. This is the workflow file. For GitHub to recognize it as one (or to enable the action), you need to rename it to `schedule-posts.yml`.

In order to use this you need to save all of your "Completed" blog posts which are scheduled to be uploaded on a specific date, in a folder named `_scheduled/` in the root directory.

> Incomplete posts should be saved in `_drafts/`

### Name Format

In this folder you need to store your file in the same format as you would in `_posts/`

> Example file name: `2024-08-26-This file will be uploaded on 26 August.md`

### Important Notes

- The scheduler uploads posts everyday at 🕛 23:30 UTC
- It will only upload posts at 23:30 UTC of their respective scheduled days, It's not uploaded in 23:59 in case there are a lot of files as the scheduler must finish before 00:00
- It will only upload files which follow the pattern `yyyy-mm-dd-title.md`
  - This means that only markdown files will be posted
  - It means that any markdown which do not follow this pattern will not be posted
- The scheduler works by moving posts from the `_scheduled/` directory to `_posts/`, it will not post to folders like `_projects/` or `_news/`
- The date in the name of the file is the day that file will be uploaded on
  - `2024-08-27-file1.md` will not be posted before or after 27-August-2024 (Scheduler only works for posts scheduled on the present day)
  - `2025-08-27-file2.md` will be posted exactly on 27-August-2025
  - `File3.md` will not be posted at all
  - `2026-02-31-file4.md` is supposed to be posted on 31-February-2026, but there is no 31st in February hence this file will never be posted either

## 创建新的博客文章

要创建新的博客文章，你可以在 [\_posts](_posts/) 目录下添加一个新的 Markdown 文件。[文件名必须遵循](https://jekyllrb.com/docs/posts/#creating-posts)格式 `YYYY-MM-DD-title.md`。最简单的方法是复制一个现有的博客文章并修改它。注意某些博客文章在 [frontmatter](https://jekyllrb.com/docs/front-matter/) 中有可选字段，用于启用特定的行为或功能。

如果你想创建尚未准备好发布的博客文章，但想用 git 追踪它们，你可以创建一个 [\_drafts](https://jekyllrb.com/docs/posts/#drafts) 目录并将它们存储在那里。
