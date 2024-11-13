---
layout: post
title: DailyLog + Cursor + Foam：打造个人知识与成长闭环
date: 2024-11-13 10:30:00
description: 一个面向开发者的知识管理系统，从想法记录到项目实现的完整工作流
tags: cursor dailylog knowledge-management
categories: tools
featured: false
---


我们的需求很简单：作为一个开发者，需要一个轻量级的日常记录工具来管理想法和知识。目前的解决方案是：使用 VS Code + Foam 插件来进行日常记录，通过 Git 进行版本控制，所有笔记都用 Markdown 格式存储在 journal/ 目录下，使用 [[wiki-links]] 和 #tags 来组织内容关联。不需要复杂的网站部署，不需要花哨的功能，就保持最简单的记录和版本控制，让工具回归到服务内容的本质。


所以我们开发了 [DailyLog](https://github.com/1587causalai/DailyLog.git), DailyLog 是一个面向开发者的个人知识与成长管理系统。它注重与 Cursor (VS Code 的 AI 增强版本) 的无缝集成，让你能够从快速记录想法到深度开发实现，最后到成果展示，形成一个完整的工作流程。

## Foam 是什么？


https://github.com/foambubble/foam


个人最喜欢的三个功能是：
- Daily note
- 建立笔记链接：运用 Foam 的快捷方式和自动补全功能，通过[[wikilinks]]在笔记间创建链接，实现知识图谱的构建与导航。
- 查看知识图谱：执行Foam: Show Graph命令，将工作区视为连接的图谱，了解笔记连接关系，还可通过标签探索、反向链接等功能探索想法间的关系。



