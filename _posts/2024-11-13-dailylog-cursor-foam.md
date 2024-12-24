---
layout: post
title: Cursor + Foam：DailyLog 打造个人知识与成长闭环
date: 2024-11-13 10:30:00
description: 一个面向开发者的日程安排和知识管理系统
tags: cursor dailylog knowledge-management
categories: tools
featured: false
---

## 背景需求

作为一名开发者，我需要一个结合开发环境和思维工具的个人知识管理系统。我特别看重使用 Cursor 作为主要的开发和思考工具，因为它能将编程环境的强大功能与 AI 辅助思考完美结合。

核心特性要求:

- 每日安排：能够规划、记录和回顾每天的工作内容
- 创意激发：通过 Cursor AI 辅助进行 Brainstorm，捕捉和发展想法
- 知识沉淀：将日常记录和头脑风暴的成果形成知识积累

为什么不用现成的解决方案（如飞书文档或时间管理软件）？因为我需要一个能与 Cursor 深度集成的系统。我把 Cursor 视为我的"思维伙伴"，它不仅是开发工具，更是我进行深度思考的助手。通过这个自定义的系统，我可以：

- 在 Cursor 中快速记录每日计划和总结
- 利用 AI 进行头脑风暴和想法扩展
- 将 Brainstorm 的成果直接转化为开发任务
- 在同一环境中完成从构思到编码的全过程

## DailyLog 项目介绍

基于上述需求，我开发了 DailyLog 一个面向开发者的个人知识与成长管理系统。它的工作流程是：

1. **每日安排（Daily Planning）**

   - 在 journal/YYYY-MM-DD.md 中记录每日计划
   - 使用 Cursor AI 辅助制定和优化计划
   - 随时记录工作进展和思考

2. **头脑风暴（Brainstorm）**

   - 在 journal/brainstorm/ 中记录创意想法
   - 与 Cursor AI 进行深度对话，拓展思路

3. **知识整理**
   - 用 Foam 的知识图谱可视化想法关联
   - 通过标签系统组织内容主题
   - 选择性地分享和发布成果

## Foam 支持功能

[Foam](https://github.com/foambubble/foam) 作为基础框架，为上述工作流提供了必要的工具支持：

1. Daily note：支持每日计划和记录
2. 笔记链接：通过 [[wikilinks]] 快速关联计划、想法和项目
3. 知识图谱：
   - 通过 "Foam: Show Graph" 命令可视化笔记关系
   - 支持标签探索
   - 提供反向链接功能
   - 帮助发现想法间的潜在联系
