---
name: codebase-to-course
description: "Turn any codebase into a beautiful, interactive single-page HTML course that teaches how the code works to non-technical people, written in Simplified Chinese by default. Use this skill whenever someone wants to create an interactive course, tutorial, or educational walkthrough from a codebase or project. Also trigger when users mention 'turn this into a course,' 'explain this codebase interactively,' 'teach this code,' 'interactive tutorial from code,' 'codebase walkthrough,' 'learn from this codebase,' 'make a course from this project,' '把代码变成课程', or '用中文讲解这个项目.' This skill produces a stunning, self-contained HTML file with scroll-based navigation, animated visualizations, embedded quizzes, and code-with-plain-Chinese side-by-side translations."
---

# Codebase-to-Course

Transform any codebase into a stunning, interactive course. The output is a **directory** containing a pre-built `styles.css`, `main.js`, per-module HTML files, and an assembled `index.html` — open it directly in the browser with no setup required (only external dependency: Google Fonts CDN). The course teaches how the code works through scroll-based modules, animated visualizations, embedded quizzes, and plain-language translations of code.

## 输出语言（硬性要求）

**课程默认使用简体中文输出。** 生成的最终 `index.html` 打开后，看到的每一段文字都应该是中文。具体规则：

- 课程标题、模块标题、屏幕小标题、正文、按钮文案、测验题目与解析、提示框（callout）、术语气泡（tooltip）、可视化元素的说明文字、`alt` 文本，全部使用简体中文。
- **绝不翻译代码本身**：代码片段必须与真实代码库逐字符一致（变量名、函数名、字符串、注释照抄），这样才能和真实文件对得上。代码旁边的讲解列用中文。
- 技术术语第一次出现时用「中文（English）」的格式，例如「命名空间包（namespace package）」「回调（callback）」——这能帮学习者建立中英文词汇对应，是他们跟 AI 沟通时的关键资产。
- 允许保留英文的只有：代码标识符、文件路径、URL、命令行参数、第三方库与产品名称。
- 不要残留任何未翻译的英文整句或英文界面文案（例如 "Check Answers"、"Next Step"、"Click here"）。
- `main.js`、`_base.html` 里的固定界面文案已经中文化，**不要改回英文**。若用户明确要求其它语言，先确认后再同步翻译这些固定文案。

**中文字体已经配置好**：`references/styles.css` 和 `references/_base.html` 的字体栈里内置了 `Noto Sans SC` / `Noto Serif SC` / `PingFang SC` 等中文兜底字体，**不要删除或简化字体栈**，否则中文会退化成系统默认字体，观感会明显变差。

## First-Run Welcome

When the skill is first triggered and the user hasn't specified a codebase yet, introduce yourself and explain what you do:

> **我可以把任何代码库变成一门交互式课程，完全不需要编程基础就能看懂它是怎么跑起来的。**
>
> 只要给我一个项目：
> - **本地文件夹** —— 例如「把 ./my-project 变成课程」
> - **GitHub 链接** —— 例如「用 https://github.com/user/repo 做一门课」
> - **当前项目** —— 如果你已经在某个代码库目录下，直接说「把这个项目变成课程」
>
> 我会通读代码、理清各部分如何协作，然后生成一个漂亮的单页 HTML 课程，包含动画图解、中文代码讲解和互动测验。全部在浏览器里运行，零配置。

（如果用户用英文提问，就用英文回复上面的介绍；课程内容的语言规则不变——除非用户明确指定，否则正文一律中文。）

If the user provides a GitHub link, clone the repo first (`git clone <url> /tmp/<repo-name>`) before starting the analysis. If they say "this codebase" or similar, use the current working directory.

## Who This Is For

The target learner is a **"vibe coder"** — someone who builds software by instructing AI coding tools in natural language, without a traditional CS education. They may have built this project themselves (without looking at the code), or they may have found an interesting open-source project on GitHub and want to understand how it's built. Either way, they don't yet understand what's happening under the hood.

**Assume zero technical background.** Every CS concept — from variables to APIs to databases — needs to be explained in plain language as if the learner has never encountered it. No jargon without definition. No "as you probably know." The tone should be like a smart friend explaining things, not a professor lecturing.

**Their goals are practical, not academic:**
- Have enough technical knowledge to effectively **steer AI coding tools** — make better architectural and tech stack decisions
- **Detect when AI is wrong** — spot hallucinations, catch bad patterns, know when something smells off
- **Intervene when AI gets stuck** — break out of bug loops, debug issues, unblock themselves
- Build more advanced software with **production-level quality and reliability**
- Be **technically fluent** enough to discuss decisions with engineers confidently
- **Acquire the vocabulary of software** — learn the precise technical terms so they can describe requirements clearly and unambiguously to AI coding agents (e.g., knowing to say "namespace package" instead of "shared folder thing")

**They are NOT trying to become software engineers.** They want coding as a superpower that amplifies what they're already good at. They don't need to write code from scratch — they need to *read* it, *understand* it, and *direct* it.

## Why This Approach Works

This skill inverts traditional CS education. The old model is: memorize concepts for years → eventually build something → finally see the point (most people quit before step 3). This model is: **build something first → experience it working → now understand how it works.**

The learner already has context that traditional students don't — they've *used* the app, they know what it does, they may have even described its features in natural language. The course meets them where they are: "You know that button you click? Here's what happens under the hood when you click it."

Every module answers **"why should I care?"** before "how does it work?" The answer to "why should I care?" is always practical: *because this knowledge helps you steer AI better, debug faster, or make smarter architectural decisions.*

The directory-based output is intentional: separating CSS/JS from content means AI never regenerates boilerplate, each module is written independently (keeping output size small and quality high), and the assembled `index.html` works offline with zero setup.

---

## The Process

### Phase 1: Codebase Analysis

Before writing course HTML, deeply understand the codebase. Read all the key files, trace the data flows, identify the "cast of characters" (main components/modules), and map how they communicate. Thoroughness here pays off — the more you understand, the better the course.

**What to extract:**
- The main "actors" (components, services, modules) and their responsibilities
- The primary user journey (what happens when someone uses the app end-to-end)
- Key APIs, data flows, and communication patterns
- Clever engineering patterns (caching, lazy loading, error handling, etc.)
- Real bugs or gotchas (if visible in git history or comments)
- The tech stack and why each piece was chosen

**Figure out what the app does yourself** by reading the README, the main entry points, and the UI code. Don't ask the user to explain the product — they may not be familiar with it either. The course should open by explaining what the app does in plain language (a brief "here's what this thing does and why it's interesting") before diving into how it works. The first module should start with a concrete user action — "imagine you paste a YouTube URL and click Analyze — here's what happens under the hood."

**产出规格：** 分析结论不落盘，直接进入 Phase 2。若判定要走 Parallel 路径，必须把要用到的代码片段**连同文件路径与行号**抄进 `course-name/briefs/`（写作 agent 不会再读代码库）。

### Phase 2: Curriculum Design

Structure the course as **4-6 modules**. Most courses need 4-6. Only go to 7-8 if the codebase genuinely has that many distinct concepts worth teaching. Fewer, better modules beat more, thinner ones.

The arc always starts from what the learner already knows (the user-facing behavior) and moves toward what they don't (the code underneath). Think of it as zooming in: start wide with the experience, then progressively peel back layers.

| Module Position | Purpose | Why it matters for a vibe coder |
|---|---|---|
| 1 | "Here's what this app does — and what happens when you use it" | Start with the product (what it does, why it's interesting), then trace a core user action into the code. Grounds everything in something concrete. |
| 2 | Meet the actors | Know which components exist so you can tell AI "put this logic in X, not Y" |
| 3 | How the pieces talk | Understand data flow so you can debug "it's not showing up" problems |
| 4 | The outside world (APIs, databases) | Know what's external so you can evaluate costs, rate limits, and failure modes |
| 5 | The clever tricks | Learn patterns (caching, chunking, error handling) so you can request them from AI |
| 6 | When things break | Build debugging intuition so you can escape AI bug loops |
| 7 | The big picture | See the full architecture so you can make better decisions about what to build next |

这是**菜单，不是清单**。按代码库规模取用，不要一律按 7 个写：

- **4 个模块**：单入口 CLI、库、脚本、单页小工具
- **5-6 个模块**：有前端 + 后端的应用，或涉及外部服务 / 数据库
- **7-8 个模块**：仅当存在 7 个以上彼此独立、各自值得单独讲的机制；否则把相邻模块合并

**The key principle:** Every module should connect back to a practical skill — steering AI, debugging, making decisions. If a module doesn't help the learner DO something better, cut it or reframe it until it does.

**Each module should contain:**
- 3-6 screens (sub-sections that flow within the module)
- At least one code-with-plain-Chinese translation block (代码 ↔ 中文讲解)
- At least one interactive element (quiz, visualization, or animation)
- One or two "aha!" callout boxes with universal CS insights
- A metaphor that grounds the technical concept in everyday life — but NEVER reuse the same metaphor across modules, and NEVER default to the "restaurant" metaphor (it's overused). Pick metaphors that organically fit the specific concept. The best metaphors feel *inevitable* for the concept, not forced.

**Mandatory interactive elements (every course must include ALL of these):**
- **Group Chat Animation** — at least one across the course. These are the iMessage/WeChat-style conversations between components. They're one of the most engaging elements and must always appear, even if you have to creatively frame a module's concept as a conversation between actors.
- **Message Flow / Data Flow Animation** — at least one across the course. The step-by-step packet animation between actors. If the codebase has any kind of request/response, data pipeline, or multi-step process, animate it. Every codebase has data flowing somewhere — find it.
- **Code ↔ 中文 Translation Blocks (代码 ↔ 中文讲解)** — at least one per module (already required above, but reiterating: this is non-negotiable). The left panel is the untouched original code; the right panel explains each line in plain Chinese.
- **Quizzes** — at least one per module (multiple-choice, scenario, drag-and-drop, or spot-the-bug — any quiz type counts).
- **Glossary Tooltips** — on every technical term, first use per module.

These five element types are the backbone of every course. Other interactive elements (architecture diagrams, layer toggles, pattern cards, etc.) are optional and should be added when they fit. But the five above must ALWAYS be present — no exceptions.

**Do NOT present the curriculum for approval — just build it.** The user wants a course, not a planning document. Design the curriculum internally, then go straight to building. If they want changes, they'll tell you after seeing the result.

**After designing the curriculum, decide which build path to use:**

- **Simple codebase** (single-purpose CLI, small web app, library, one clear entry point, 5 or fewer modules) → go directly to Phase 3 Sequential.
- **Complex codebase** (full-stack app, multiple services, content-heavy site, monorepo, or 6+ modules) → go to Phase 2.5 first, then Phase 3 Parallel.

### Phase 2.5: Module Briefs (complex codebases only)

For complex codebases, write a brief for each module before writing any HTML. This is the critical step that enables parallel writing — each brief gives an agent everything it needs without re-reading the codebase.

Read `references/module-brief-template.md` for the template structure. Read `references/content-philosophy.md` for the content rules that should guide brief writing.

**For each module, write a brief to `course-name/briefs/0N-slug.md` containing:**
- Teaching arc (metaphor, opening hook, key insight)
- Pre-extracted code snippets (copy-pasted from the codebase with file paths and line numbers)
- Interactive elements checklist with enough detail to build them
- Which sections of which reference files the writing agent needs
- What the previous and next modules cover (for transitions)

The code snippets are the critical token-saving step. By pre-extracting them into the brief, writing agents never need to read the codebase at all.

### Phase 3: Build the Course

The course output is a **directory**, not a single file. All CSS and JS are pre-built reference files — never regenerate them. Your job is to write only the HTML content.

**Output structure:**
```
course-name/
  styles.css       ← copied verbatim from references/styles.css
  main.js          ← copied verbatim from references/main.js
  _base.html       ← customized shell (title, accent color, nav dots)
  _footer.html     ← copied verbatim from references/_footer.html
  build.sh         ← copied verbatim from references/build.sh
  briefs/          ← module briefs (complex codebases only, can delete after build)
  modules/
    01-intro.html
    02-actors.html
    ...
  index.html       ← assembled by build.sh (do not write manually)
```

**Step 1 (both paths): Setup** — Create the course directory. Copy these four files verbatim using Read + Write (do not regenerate their contents):
- `references/styles.css` → `course-name/styles.css`
- `references/main.js` → `course-name/main.js`
- `references/_footer.html` → `course-name/_footer.html`
- `references/build.sh` → `course-name/build.sh`

**Step 2 (both paths): Customize `_base.html`** — Read `references/_base.html`, then write it to `course-name/_base.html` with exactly three kinds of substitution:
- Both instances of `COURSE_TITLE` → the actual course title
- The four `ACCENT_*` placeholders → the chosen accent color values (pick one palette from the comments in `_base.html`)
- `NAV_DOTS` → one `<button class="nav-dot" ...>` per module（按钮数量必须等于模块数，`data-target` 依次为 `module-1`、`module-2`…，与 `.module` 的 `id` 一一对应）

**Step 3: Write modules** — This is where the paths diverge.

#### Sequential path (simple codebases)

Read `references/content-philosophy.md` and `references/gotchas.md`. Then write modules one at a time. For each module, write `course-name/modules/0N-slug.html` containing only the `<section class="module" id="module-N">` block and its contents. Do not include `<html>`, `<head>`, `<body>`, `<style>`, or `<script>` tags.

Read `references/interactive-elements.md` for HTML patterns for each interactive element type. Read `references/design-system.md` for visual conventions.

#### Parallel path (complex codebases)

Dispatch modules to subagents in batches of up to 3. Each agent receives:
- Its module brief (from `course-name/briefs/`)
- `references/content-philosophy.md` and `references/gotchas.md`
- Only the sections of `references/interactive-elements.md` and `references/design-system.md` listed in the brief

Each agent writes its module file(s) to `course-name/modules/`. Short modules (3 screens, one quiz) can be paired — two briefs given to one agent.

**What agents do NOT receive:** the full codebase (snippets are in the brief), SKILL.md, other modules' briefs, or unneeded reference file sections.

After all agents finish, do a quick consistency check in the main context: nav dots match modules, transitions between modules are coherent, no obvious tone shifts.

**Step 4 (both paths): Assemble** — Run `build.sh` from the course directory:
```bash
cd course-name && bash build.sh
```
This produces `index.html`. Open it in the browser.

**Critical rules:**
- **Never regenerate** `styles.css` or `main.js` — always copy from references
- Module files contain only `<section>` content — no boilerplate
- Use CSS `scroll-snap-type: y proximity` (NOT `mandatory`)
- Use `min-height: 100dvh` with `100vh` fallback on `.module`
- Interactive element JS is in `main.js`; wire up via `data-*` attributes and CSS class names as shown in `references/interactive-elements.md`
- Chat containers need `id` attributes; flow animations need `data-steps='[...]'` JSON on `.flow-animation`

### Phase 4: Review and Open

After running `build.sh`, open `index.html` in the browser, then do exactly these two things:

1. 用一句话交代结构：几个模块、每个模块讲什么、`index.html` 在哪个目录。
2. 依次问下面三个固定问题，并等用户回答：
   - 哪一屏的讲解你没看懂？（内容）
   - 配色、字体、间距哪里不舒服？（设计）
   - 哪个交互元素点了没反应，或者玩法不直观？（交互）

拿到反馈后，改对应的 `modules/*.html` 或 `_base.html`，重新跑 `bash build.sh`。

---

## 失败模式与兜底

执行途中遇到下面任一情况，**先走「一线修复」；仍失败再走「兜底」**，并在最终汇报里说明降级了什么、影响哪些模块。

| 触发条件 | 一线修复 | 仍失败兜底 |
|---|---|---|
| 找不到入口文件，或项目没有 README | 用 `package.json` / `pyproject.toml` / `Cargo.toml` / `Makefile` / `init.py` 定位入口 | 直接问用户一句「这个项目平时怎么跑起来？」，拿到答案再继续 |
| 代码库超过 200 个文件 | 只读入口文件 + 两层目录树，跳过 `vendor/`、`node_modules/`、构建产物 | 让用户指定 2-3 个重点目录，其余只做目录级概述 |
| 用户只给 GitHub 链接，且仓库私有 | 提示改用本地路径，或设置 `GITHUB_TOKEN` 后重试 clone | 请用户本地 clone 后把路径给你，跳过远程步骤 |
| 子 agent 不可用或超时 | 放弃 Parallel 路径，改走 Sequential 逐模块写 | 模块数压到 4 个，先保住每模块的强制元素，砍掉可选元素 |
| `bash build.sh` 报错 | 检查 `modules/*.html` 是否只含 `<section>`，文件名是否按 01/02 排序 | 手动拼接：`cat _base.html modules/*.html _footer.html > index.html` |
| 打开 `index.html` 样式全丢或整页空白 | 检查 `_base.html` 里 `styles.css`、`main.js` 的相对路径与真实文件名是否一致 | 把 CSS/JS 内联进 `index.html`，作为单文件兜底 |
| 群聊动画 / 数据流动画不动 | 检查 `.chat-window` 是否有唯一 `id`，`.flow-animation` 的 `data-steps` JSON 是否用单引号定界 | 换成静态 `.flow-steps` + 文字说明，保证没有 JS 也能读懂 |
| 某个模块写到一半被截断 | 拆成 2-3 次写入，或先写 4 个核心模块再补其它 | 降级为 4 模块 × 3 屏，优先保住代码讲解与测验 |
| 页面上残留英文界面文案 | 对照 `references/interactive-elements.md` 顶部的固定文案对照表逐条替换 | 扫一遍 `index.html`，凡是面向学习者的英文整句一律替换 |
| 用户中途要求换语言 | 按用户语言重写正文，并同步替换 `main.js` 里的固定文案 | 至少保证按钮、测验反馈与正文语言一致，不留混排 |

---

## Design Identity

The visual design should feel like a **beautiful developer notebook** — warm, inviting, and distinctive. Read `references/design-system.md` for the full token system, but here are the non-negotiable principles:

- **Warm palette**: Off-white backgrounds (like aged paper), warm grays, NO cold whites or blues
- **Bold accent**: One confident accent color (vermillion, coral, teal — NOT purple gradients)
- **Distinctive typography**: 标题字体固定用 `Bricolage Grotesque`、正文 `DM Sans`、代码 `JetBrains Mono` —— 直接照抄 `references/design-system.md` 里的 `--font-display` / `--font-body` / `--font-mono`（已含中文兜底，不要替换、不要精简）。禁止 Inter、Roboto、Arial、Space Grotesk。
- **Generous whitespace**: Modules breathe. Max 3-4 short paragraphs per screen.
- **Alternating backgrounds**: Even/odd modules alternate between two warm background tones for visual rhythm
- **Dark code blocks**: IDE-style with Catppuccin-inspired syntax highlighting on deep indigo-charcoal (#1E1E2E)
- **Depth without harshness**: Subtle warm shadows, never black drop shadows

---

## Reference Files

The `references/` directory contains detailed specs. **Read them only when you reach the relevant phase** — not upfront. This keeps context lean.

- **`references/content-philosophy.md`** — Visual density rules, metaphor guidelines, quiz design, tooltip rules, code translation guidance. Read during Phase 2.5 (briefs) and Phase 3 (writing modules).
- **`references/gotchas.md`** — Common failure points checklist. Read during Phase 3 and Phase 4 (review).
- **`references/module-brief-template.md`** — Template for Phase 2.5 module briefs. Read only for complex codebases using the parallel path.
- **`references/design-system.md`** — Complete CSS custom properties, color palette, typography scale, spacing system, shadows, animations, scrollbar styling. Read during Phase 3 when writing module HTML.
- **`references/interactive-elements.md`** — Implementation patterns for every interactive element: drag-and-drop quizzes, multiple-choice quizzes, code↔中文 translations, group chat animations, message flow visualizations, architecture diagrams, pattern cards, callout boxes. It also lists the standard Chinese UI labels (按钮 / 标题 / 提示文案) that must be used verbatim. Read the relevant sections during Phase 3.
