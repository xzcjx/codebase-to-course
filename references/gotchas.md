# Gotchas — Common Failure Points

> **When to read this:** During Phase 3 (writing module HTML) and Phase 4 (review). Check every one of these before considering a course complete.

These are real problems encountered when building courses. Check every one before considering a course complete.

### 英文残留（课程是中文课程时最容易犯的错）
最典型的问题是页面上还留着英文：按钮写着 "Check Answers"、"Next Step"，提示框写着 "Key Insight"，测验反馈写着 "Exactly!"，导航 aria-label 写着 "Module 3"。**检查方法：** 最终 `index.html` 里搜索 `>` 后面紧跟的英文单词，凡是面向学习者的界面文字必须是中文。固定文案统一用 `references/interactive-elements.md` 顶部的中英对照表。允许保留英文的只有代码、文件路径、URL、库名。

### Tooltip Clipping
Translation blocks use `overflow: hidden` for code wrapping. If tooltips use `position: absolute` inside the term element, they get clipped by the container. **Fix:** Tooltips must use `position: fixed` and be appended to `document.body`. Calculate position from `getBoundingClientRect()`. This is already handled by `main.js` but is the #1 bug that appears in every build. 注意：气泡内部如果显示中文，`max-height` 一类的过渡值要留够高度，中文换行比英文多。

### Not Enough Tooltips
The most common failure is under-tooltipping. Non-technical learners don't know terms like REPL, JSON, flag, entry point, PATH, pip, namespace, function, class, module, PR, E2E, or even software names like Blender/GIMP. **Rule of thumb:** if a term wouldn't appear in everyday conversation with a non-technical friend, tooltip it. Err heavily on the side of too many. BUT: don't tooltip terms the user already knows well from their domain (e.g., AI/ML concepts for someone in AI).

### Walls of Text
The course looks like a textbook instead of an infographic. This happens when you write more than 2-3 sentences in a row without a visual break. Every screen must be at least 50% visual. Convert any list of 3+ items into cards, any sequence into step cards or flow diagrams, any code explanation into a code↔中文 translation block. 中文段落尤其容易「糊成一块」，句子要更短，一段最多 2-3 句。

### Recycled Metaphors
Using "restaurant" or "kitchen" for everything. Every module needs its own metaphor that feels inevitable for that specific concept. If you catch yourself reaching for the same metaphor twice, stop and find one that fits the concept organically.

### Code Modifications
Trimming, simplifying, or "cleaning up" code snippets from the codebase. The learner should be able to open the real file and see the exact same code. Instead of editing code to be shorter, *choose* naturally short snippets (5-10 lines) from the codebase that illustrate the point.

### Quiz Questions That Test Memory
Asking "What does API stand for?" or "Which file handles X?" — those test recall, not understanding. Every quiz question should present a new scenario the learner hasn't seen and ask them to *apply* what they learned.

### Scroll-Snap Mandatory
Using `scroll-snap-type: y mandatory` traps users inside long modules. Always use `proximity`.

### Module Quality Degradation
Trying to write all modules in one pass causes later modules to be thin and rushed. Build one module at a time and verify each before moving on. For complex codebases, use the parallel path with module briefs.

### Missing Interactive Elements
A module with only text and code blocks, no interactivity. Every module needs at least one of: quiz, data flow animation, group chat, architecture diagram, drag-and-drop. These aren't decorations — they're how non-technical learners actually process information.
