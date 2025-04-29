# 我的博客文章格式规范 (My Blog Post Format Rules)

Okay，为了让这个博客项目 (`1587causalai.github.io`) 的文章管理起来更清晰、更系统化，也为了以后方便 AI (比如你！) 理解我的需求，我给自己定了这么一套写博文的标准格式和规范。以后所有新文章都得按这个来：

## 1. 文件位置和命名 (File Location & Naming)

*   **位置 (Location):** 所有博文的 Markdown 文件都必须放在项目根目录下的 `_posts` 文件夹里。
*   **命名规范 (Naming Convention):** 文件名必须严格遵守 `YYYY-MM-DD-kebab-case-title.md` 格式。
    *   `YYYY-MM-DD`: 代表文章的发布日期。
    *   `kebab-case-title`: 是文章标题的简写，用小写字母，单词之间用短横线 `-` 连接 (kebab-case)。**这部分请使用英文**，因为它会影响最终生成的 URL。
    *   **示例 (Example):** `2025-04-29-qwen3-release-analysis.md`

## 2. 元数据 (Front Matter)

这是每篇文章 Markdown 文件开头，用三个短横线 `---` 包裹起来的部分，用来定义文章的各种属性。这块信息**极其重要**，格式必须正确。

### 2.1 必须包含的字段 (Required Fields)

这几个是每篇文章都**必须有**的：

*   `layout: post`
    *   **用途:** 指定页面使用的布局模板。
    *   **值:** 固定写 `post` 就行。
*   `title: "Your Post Title"`
    *   **用途:** 文章的主标题，会显示在页面顶部和浏览器标签页上。
    *   **值:** **必须使用英文标题**。如果标题包含特殊字符（比如冒号 `:`），请用英文双引号 `""` 把整个标题包起来。
    *   **示例:** `title: "Qwen3 Release: An In-depth Analysis"`
*   `date: YYYY-MM-DD` (或 `YYYY-MM-DD HH:MM:SS ZZZZ`)
    *   **用途:** 文章的正式发布日期。Jekyll 会根据这个日期来排序和处理文章。
    *   **值:** 至少要包含年月日 `YYYY-MM-DD`。如果需要更精确的时间，可以加上 `HH:MM:SS` 和时区信息，比如 `2025-04-29 10:30:00 -0400`。

### 2.2 强烈推荐的字段 (Highly Recommended Fields)

这些字段虽然不是强制的，但强烈建议加上，对 SEO、内容组织和用户体验都很有帮助：

*   `description: "A brief english summary..."`
    *   **用途:** 文章内容的简短英文摘要。搜索引擎会用它，网站内部也可能在列表页或分享时显示。
    *   **值:** **必须是英文**，写一两句概括文章核心内容的话。
    *   **示例:** `description: "Analyzing the features, performance, and implications of the new Qwen3 large language model release."`
*   `tags: english tag1 tag2` (或 `tags: [tag1, tag2]`)
    *   **用途:** 给文章打上关键词标签，方便分类索引和用户查找相关内容。
    *   **值:** **必须是英文**，小写。多个标签用空格隔开，或者用 YAML 列表格式。
    *   **示例:** `tags: ai llm qwen release analysis` 或 `tags: [ai, llm, qwen, release, analysis]`
*   `categories: EnglishCategory` (或 `categories: [category1, category2]`)
    *   **用途:** 文章的主要分类，比标签更宏观一些。
    *   **值:** **必须是英文**，首字母大写或遵循你的分类体系。通常只指定一个主要分类，但也可以是列表。
    *   **示例:** `categories: AI-Research` 或 `categories: [Technology, AI]`

### 2.3 按需使用的可选字段 (Optional / Contextual Fields)

根据文章的具体需求，可以添加以下字段：

*   `giscus_comments: true`
    *   **用途:** 控制是否启用 Giscus 评论系统。
    *   **值:** 我大部分文章都会开启评论，所以一般设为 `true`。
*   `featured: true`
    *   **用途:** 标记为精选文章，可能会在首页或其他地方特殊展示。
    *   **值:** `true` 或 `false` (默认不写就是 `false`)。
*   `toc:`
    *   **用途:** 控制是否显示以及如何显示文章目录 (Table of Contents)。
    *   **值:** 需要显示时，通常用 `toc: { beginning: true }` 把它放在文章开头。具体配置可能依赖主题。
*   `citation: true`
    *   **用途:** 表明这篇文章需要引用功能。
    *   **值:** `true`。
*   `bibliography: assets/bibliography.bib`
    *   **用途:** 当 `citation: true` 时，指定参考文献 `.bib` 文件的路径。
    *   **值:** 指向你的 bib 文件路径，例如 `assets/bibliography.bib`。
*   `related_posts: true` / `false`
    *   **用途:** 控制文章末尾是否显示相关文章列表。
    *   **值:** `true` 或 `false`。

### 2.4 Front Matter 完整示例 (Complete Example)

\`\`\`yaml
---
layout: post
title: "Qwen3 Release: An In-depth Analysis"
date: 2025-04-29 11:00:00 -0400
description: "Analyzing the features, performance, and implications of the new Qwen3 large language model release."
tags: [ai, llm, qwen, release, analysis]
categories: AI-Research
giscus_comments: true
featured: false
toc:
  beginning: true
---

(这里开始是文章的正文 Markdown 内容...)
\`\`\`

## 3. 核心原则 (Core Principle)

**保持一致性 (Consistency is Key)!** 严格遵守这个格式，特别是文件名和必需的元数据。这样做不仅让整个博客项目看起来专业整洁，更重要的是，极大地简化了内容管理和维护工作，也为将来可能的自动化处理（比如用脚本检查格式、自动生成索引页，或者让 AI 助手帮你处理文章）打下了坚实的基础。
