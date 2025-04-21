# Hugo 博客内容协作说明

欢迎参与 **Battle of BUAA 卡牌资料站** 的内容编辑！以下是你需要了解的基本操作：

## 📁 文件放哪里？

请将你的内容文件（Markdown 格式）放到以下目录：

```
# 展示在主页的帖子
content/posts/
# 关于我们
content/about/
```

## 📄 内容文件格式

使用 Markdown (`.md`) 编写，每个文件开头需要有一个 “Front Matter”，用于描述文章的基本信息。例如：

```markdown
---
title: "神射手 · 卡牌技能介绍"
date: 2025-04-21
tags: ["技能机制", "神射手"]
draft: false
---

这里是正文内容，你可以使用 Markdown 语法自由编辑。

- 技能名称：多重箭矢  
- 触发机制：每攻击第三次额外造成一次伤害  
- 效果数值：+50% 物理伤害
```

## 📷 图片或资源放哪？

请将图片放在：

```
static/images/
```

引用方式：

```markdown
![技能示意图](/images/icon.png)
```

## 🚀 如何预览？

如果你本地有 Hugo 环境，可以在项目根目录运行：

```bash
hugo server -D
```

打开浏览器访问 `http://localhost:1313` 查看效果。

🧙‍♂️ 感谢你的贡献，一起让 Battle of BUAA 更丰富、更专业！
