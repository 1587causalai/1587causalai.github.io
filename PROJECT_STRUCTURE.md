# 项目结构说明

## 目录结构

```
(base) ➜  1587causalai.github.io git:(main) ✗ ls
CONTRIBUTING.md         Gemfile                 README.md               _includes               _plugins                _site                   docker-compose.yml      purgecss.config.js
CUSTOMIZE.md            Gemfile.lock            _bibliography           _layouts                _posts                  assets                  lighthouse_results      readme_preview
Dockerfile              INSTALL.md              _config.yml             _news                   _projects               bin                     package-lock.json       requirements.txt
FAQ.md                  LICENSE                 _data                   _pages                  _sass                   docker-compose-slim.yml package.json            robots.txt
```

- `_bibliography/`: 存放BibTeX格式的论文引用文件
- `_data/`: 存放网站配置数据，如CV信息
- `_includes/`: 存放可重用的HTML片段
- `_layouts/`: 存放页面布局模板
- `_pages/`: 存放主要页面内容
- `_posts/`: 存放博客文章
- `_projects/`: 存放项目展示内容
- `_sass/`: 存放样式文件
- `assets/`: 存放静态资源(图片、PDF等)

## 快速开始

1. 修改 `_config.yml` 中的个人信息
2. 在 `_pages/about.md` 编辑个人简介
3. 在 `_bibliography/papers.bib` 添加论文
4. 在 `_projects/` 添加项目
5. 在 `_posts/` 发布博客

## 常用自定义

- 修改主题色: 编辑 `_sass/_themes.scss`
- 添加新页面: 在 `_pages/` 创建新的 markdown 文件
- 更新导航栏: 编辑 `_data/navigation.yml`
