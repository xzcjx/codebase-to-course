# Codebase to Course

An Agent Skill that turns any codebase into a beautiful, interactive single-page HTML course.

Point it at a repo. Get back a stunning, self-contained course that teaches how the code works — with scroll-based navigation, animated visualizations, embedded quizzes, and code-with-plain-English side-by-side translations.

## Who is this for?

**"Vibe coders"** — people who build software by instructing AI coding tools in natural language, without a traditional CS education.

You've built something (or found something cool on GitHub). It works. But you don't really understand *how* it works under the hood. This skill generates a course that teaches you — not by lecturing, but by tracing what happens when you actually use the app.

**Your goals are practical, not academic:**
- Steer AI coding tools better (make smarter architectural decisions)
- Detect when AI is wrong (spot hallucinations, catch bad patterns)
- Debug when AI gets stuck (break out of bug loops)
- Talk to engineers without feeling lost

You're not trying to become a software engineer. You want coding as a superpower.

## What the course looks like

The output is a **single HTML file** — no dependencies, no setup, works offline. It includes:

- **简体中文输出（默认）** — 课程正文、界面按钮、测验、术语气泡全部中文；代码片段保持原样，右侧配逐行中文讲解。中文字体（Noto Sans SC / Noto Serif SC）已内置兜底。
- **Scroll-based modules** with progress tracking and keyboard navigation
- **Code ↔ Plain English translations** — real code on the left, what it means on the right
<img width="720" alt="Code translation block" src="https://github.com/user-attachments/assets/fb9e7fac-05c1-4f98-b80c-46543ef81afc" />

- **Animated visualizations** — data flow animations, group chat between components, architecture diagrams
<img width="720" alt="Animated data flow" src="https://github.com/user-attachments/assets/20fb403e-7dfd-4a47-989b-bbae86ca8041" />

- **Interactive quizzes** that test *application* not memorization ("You want to add favorites — which files change?")
<img width="720" alt="Interactive quiz" src="https://github.com/user-attachments/assets/57706496-9fa8-457a-8450-3da22789951c" />

- **Glossary tooltips** — hover any technical term for a plain-English definition
<img width="720" alt="Glossary tooltip" src="https://github.com/user-attachments/assets/ac2f160a-d73f-4779-97b2-a06fdb5f3227" />

  
- **Warm, distinctive design** — not the typical purple-gradient AI look

## How to install

适用于任何 skills-compatible runtime（Codex / Claude Code / Cursor / OpenClaw / Hermes 等）。装完之后它既是**技能**（自动触发），也是**命令**（手动调用）。

**方式 1：一键安装脚本（推荐）**

```bash
git clone https://github.com/xzcjx/codebase-to-course.git
cd codebase-to-course
bash install.sh --link     # 软链安装，改仓库文件立即生效；用 bash install.sh 则为拷贝安装
```

脚本会依次写入下面这些位置（已存在的会跳过）：

| Runtime | 目标路径 | 调用方式 |
|---|---|---|
| Codex | `~/.agents/skills/codebase-to-course/`（兼容 `~/.codex/skills/`） | `$codebase-to-course` |
| Claude Code | `~/.claude/skills/codebase-to-course/` | `/codebase-to-course` |
| Cursor | `~/.cursor/skills/codebase-to-course/` | `@codebase-to-course` |

**方式 2：手动装到某一个 runtime**

```bash
mkdir -p ~/.claude/skills            # 换成你所用 runtime 的 skills 目录
cp -r codebase-to-course ~/.claude/skills/
```

**方式 3：不安装，当参考资料用**

直接把 `SKILL.md` 的内容 `cat` 进对话上下文，agent 同样能按它执行。

### 作为命令调用

```text
Codex        $codebase-to-course 把这个项目变成一门课
Claude Code  /codebase-to-course 把这个项目变成一门课
```

不带参数时，技能默认拿**当前工作目录**当输入；也可以把项目路径或 GitHub 链接跟在后面。
Codex 会自动检测新增技能，没出现就重启 Codex。

## How to use

装好后，在你使用的 agent 里打开任意项目，然后说：
*"Turn this codebase into an interactive course"* 或 *"把这个项目变成一门课"*。

### Trigger phrases

- "Turn this into a course"
- "Explain this codebase interactively"
- "Make a course from this project"
- "Teach me how this code works"
- "Interactive tutorial from this code"

## Design philosophy

### Build first, understand later

This inverts traditional CS education. The old way: memorize concepts for years → eventually build something → finally see the point (most people quit before step 3). This way: **build something → experience it working → now understand how it works.**

### Show, don't tell

Every screen is at least 50% visual. Max 2-3 sentences per text block. If something can be a diagram, animation, or interactive element — it shouldn't be a paragraph.

### Quizzes test doing, not knowing

No "What does API stand for?" Instead: "A user reports stale data after switching pages. Where would you look first?" Quizzes test whether you can *use* what you learned to solve a new problem.

### No recycled metaphors

Each concept gets a metaphor that fits *that specific idea*. A database is a library with a card catalog. Auth is a bouncer checking IDs. API rate limiting is a nightclub with a capacity limit. Never the same metaphor twice.

### Original code only

Code snippets are exact copies from the real codebase — never modified or simplified. The learner should be able to open the actual file and see the same code they learned from.

## Skill structure

```
codebase-to-course/
├── SKILL.md                          # Main skill instructions
└── references/
    ├── design-system.md              # CSS tokens, typography, colors, layout
    └── interactive-elements.md       # Quiz, animation, and visualization patterns
```


---

## Credits

Original author: [Zara](https://x.com/zarazhangrui)（原版首发于 Claude Code 生态；本仓库为多 runtime 通用版本，并默认输出简体中文）。
