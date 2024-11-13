FOAM_TEMPLATE_DIR: _posts
FOAM_TEMPLATE_NAME: ${CURRENT_YEAR}-${CURRENT_MONTH}-${CURRENT_DATE}-${1:url-slug}.md
---
layout: post
title: ${2:标题}
date: ${CURRENT_YEAR}-${CURRENT_MONTH}-${CURRENT_DATE} ${CURRENT_HOUR}:${CURRENT_MINUTE}:00
description: ${3:描述}
tags: ${4:标签1 标签2}
categories: ${5|tools,research,projects,thoughts|}
featured: ${6|false,true|}
---

${7:正文内容}
