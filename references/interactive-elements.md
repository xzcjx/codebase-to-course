# Interactive Elements Reference

Implementation patterns for every interactive element type used in courses. Pick the elements that best serve each module's teaching goal.

> **Architecture note:** All CSS and JavaScript for these elements live in `references/styles.css` and `references/main.js`, which are copied verbatim into every course directory. When writing module HTML files, use only the HTML patterns below — do **not** inline `<style>` or `<script>` tags for these elements. The engines in `main.js` auto-initialize on page load by scanning for the relevant class names and `data-*` attributes described here.

> **⚠️ 文案一律使用简体中文。** 下面的示例里出现的英文只是结构占位，写模块时必须换成中文。代码片段本身除外——代码必须与真实代码库逐字一致，绝不翻译。
>
> **固定文案对照表（必须逐字使用，不要自创说法）：**
>
> | 位置 | 标准中文文案 |
> |---|---|
> | 代码块角标 | `代码` |
> | 讲解块角标 | `中文讲解` |
> | 测验按钮 | `对答案` / `再试一次` |
> | 拖拽配对按钮 | `检查配对` / `重置` |
> | 拖拽目标占位 | `拖到这里` |
> | 聊天控制按钮 | `下一条消息` / `全部播放` / `重播` |
> | 流程动画按钮 | `下一步` / `重新开始` |
> | 流程动画初始提示 | `点击「下一步」开始` |
> | 架构图提示 | `点击任意组件，看看它负责什么` |
> | 场景标签 | `场景` |
> | 提示框标题 | `关键洞察` / `注意` / `小技巧` |
> | 找 Bug 提示 | `点击你认为有问题的代码行` |
> | 术语气泡 | 中文解释，首次出现的术语写「中文（English）」 |
>
> 由 `main.js` 自动生成的文案（测验反馈、消息计数、步骤计数等）已经中文化，模块 HTML 里不需要重复写。

## Table of Contents
1. [Code ↔ 中文 Translation Blocks](#code--中文-translation-blocks)
2. [Multiple-Choice Quizzes](#multiple-choice-quizzes)
3. [Drag-and-Drop Matching](#drag-and-drop-matching)
4. [Group Chat Animation](#group-chat-animation)
5. [Message Flow / Data Flow Animation](#message-flow--data-flow-animation)
6. [Interactive Architecture Diagram](#interactive-architecture-diagram)
7. [Layer Toggle Demo](#layer-toggle-demo)
8. ["Spot the Bug" Challenge](#spot-the-bug-challenge)
9. [Scenario Quiz](#scenario-quiz)
10. [Callout Boxes](#callout-boxes)
11. [Pattern/Feature Cards](#patternfeature-cards)
12. [Flow Diagrams](#flow-diagrams)
13. [Permission/Config Badges](#permissionconfig-badges)
14. [Glossary Tooltips](#glossary-tooltips)
15. [Visual File Tree](#visual-file-tree)
16. [Icon-Label Rows](#icon-label-rows)
17. [Numbered Step Cards](#numbered-step-cards)

---

## Code ↔ 中文 Translation Blocks

The most important teaching element. Shows real code from the project on the left and a plain Chinese explanation on the right, line by line. 左侧是项目里的真实代码（原样照抄），右侧是逐行中文讲解。

**HTML:**
```html
<div class="translation-block animate-in">
  <div class="translation-code">
    <span class="translation-label">代码</span>
    <pre><code>
<span class="code-line"><span class="code-keyword">const</span> response = <span class="code-keyword">await</span> <span class="code-function">fetch</span>(url, {</span>
<span class="code-line">  <span class="code-property">method</span>: <span class="code-string">'POST'</span>,</span>
<span class="code-line">  <span class="code-property">headers</span>: { <span class="code-string">'Authorization'</span>: apiKey }</span>
<span class="code-line">});</span>
    </code></pre>
  </div>
  <div class="translation-english">
    <span class="translation-label">中文讲解</span>
    <div class="translation-lines">
      <p class="tl">向这个网址发一个请求，然后等它返回结果……</p>
      <p class="tl">我们是在「发送」数据（POST），而不只是「读取」数据（GET）……</p>
      <p class="tl">带上我们的 API 密钥，服务器才知道是谁在请求……</p>
      <p class="tl">请求的准备工作到这里就结束了。</p>
    </div>
  </div>
</div>
```

**CSS:**
```css
.translation-block {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 0;
  border-radius: var(--radius-md);
  overflow: hidden;
  box-shadow: var(--shadow-md);
  margin: var(--space-8) 0;
}
.translation-code {
  background: var(--color-bg-code);
  color: #CDD6F4;
  padding: var(--space-6);
  font-family: var(--font-mono);
  font-size: var(--text-sm);
  line-height: 1.7;
  position: relative;
  overflow-x: hidden;  /* NO horizontal scrollbar — ever */
}
.translation-code pre,
.translation-code code {
  white-space: pre-wrap;       /* wrap long lines instead of scrolling */
  word-break: break-word;      /* break mid-word if needed */
  overflow-x: hidden;
}
.translation-english {
  background: var(--color-surface-warm);
  padding: var(--space-6);
  font-size: var(--text-sm);
  line-height: 1.7;
  border-left: 3px solid var(--color-accent);
}
.translation-label {
  position: absolute;
  top: var(--space-2);
  right: var(--space-3);
  font-size: var(--text-xs);
  text-transform: uppercase;
  letter-spacing: 0.1em;
  opacity: 0.5;
}
.translation-english .translation-label {
  color: var(--color-text-muted);
}
/* Responsive: stack vertically on mobile */
@media (max-width: 768px) {
  .translation-block { grid-template-columns: 1fr; }
  .translation-english { border-left: none; border-top: 3px solid var(--color-accent); }
}
```

**Rules:**
- Each English line should correspond to 1-2 code lines
- Use conversational language, not technical jargon
- Highlight the "why" not just the "what" — e.g., "Include our API key so the server knows who we are" not "Set the Authorization header"

---

## Multiple-Choice Quizzes

For testing understanding with instant feedback. Each question has options, one correct answer, and per-question explanations.

**Wiring:** `main.js` exposes `window.selectOption(btn)`, `window.checkQuiz(containerId)`, and `window.resetQuiz(containerId)`. Call them via `onclick`. Per-question explanations go in `data-explanation-right` and `data-explanation-wrong` on the `.quiz-question-block`.

**HTML:**
```html
<div class="quiz-container" id="quiz-module3">
  <div class="quiz-question-block"
       data-correct="option-b"
       data-explanation-right="没错——因为在这套架构里，X 正是负责 Y 的那一环。"
       data-explanation-wrong="再想想。先回忆一下 Y 在代码里到底住在哪一层……">
    <h3 class="quiz-question">这里写问题？</h3>
    <div class="quiz-options">
      <button class="quiz-option" data-value="option-a" onclick="selectOption(this)">
        <div class="quiz-option-radio"></div>
        <span>选项 A</span>
      </button>
      <button class="quiz-option" data-value="option-b" onclick="selectOption(this)">
        <div class="quiz-option-radio"></div>
        <span>选项 B（正确答案）</span>
      </button>
      <button class="quiz-option" data-value="option-c" onclick="selectOption(this)">
        <div class="quiz-option-radio"></div>
        <span>选项 C</span>
      </button>
    </div>
    <div class="quiz-feedback"></div>
  </div>

  <button class="quiz-check-btn" onclick="checkQuiz('quiz-module3')">对答案</button>
  <button class="quiz-reset-btn" onclick="resetQuiz('quiz-module3')">再试一次</button>
</div>
```

**CSS for quiz states:**
```css
.quiz-option {
  display: flex; align-items: center; gap: var(--space-3);
  padding: var(--space-3) var(--space-4);
  border: 2px solid var(--color-border);
  border-radius: var(--radius-sm);
  background: var(--color-surface);
  cursor: pointer; width: 100%;
  transition: border-color var(--duration-fast), background var(--duration-fast);
}
.quiz-option:hover { border-color: var(--color-accent-muted); }
.quiz-option.selected { border-color: var(--color-accent); background: var(--color-accent-light); }
.quiz-option.correct { border-color: var(--color-success); background: var(--color-success-light); }
.quiz-option.incorrect { border-color: var(--color-error); background: var(--color-error-light); }
.quiz-option-radio {
  width: 18px; height: 18px; border-radius: 50%;
  border: 2px solid var(--color-border);
  transition: all var(--duration-fast);
}
.quiz-option.selected .quiz-option-radio {
  border-color: var(--color-accent);
  background: var(--color-accent);
  box-shadow: inset 0 0 0 3px white;
}
.quiz-feedback {
  max-height: 0; overflow: hidden; opacity: 0;
  transition: max-height var(--duration-normal), opacity var(--duration-normal);
}
.quiz-feedback.show { max-height: 200px; opacity: 1; padding: var(--space-3); margin-top: var(--space-2); border-radius: var(--radius-sm); }
.quiz-feedback.success { background: var(--color-success-light); color: var(--color-success); }
.quiz-feedback.error { background: var(--color-error-light); color: var(--color-error); }
```

---

## Drag-and-Drop Matching

For matching concepts to descriptions. Supports both mouse (HTML5 Drag API) and touch.

**HTML:**
```html
<div class="dnd-container" id="dnd-module2">
  <div class="dnd-chips">
    <div class="dnd-chip" draggable="true" data-answer="actor-a">角色 A</div>
    <div class="dnd-chip" draggable="true" data-answer="actor-b">角色 B</div>
    <div class="dnd-chip" draggable="true" data-answer="actor-c">角色 C</div>
  </div>
  <div class="dnd-zones">
    <div class="dnd-zone" data-correct="actor-a">
      <p class="dnd-zone-label">角色 A 的职责描述</p>
      <div class="dnd-zone-target">拖到这里</div>
    </div>
    <!-- more zones -->
  </div>
  <button onclick="checkDnD('dnd-module2')">检查配对</button>
  <button onclick="resetDnD('dnd-module2')">重置</button>
</div>
```

**JS (mouse + touch):**
```javascript
// MOUSE: HTML5 Drag API
chips.forEach(chip => {
  chip.addEventListener('dragstart', (e) => {
    e.dataTransfer.setData('text/plain', chip.dataset.answer);
    chip.classList.add('dragging');
  });
  chip.addEventListener('dragend', () => chip.classList.remove('dragging'));
});

zones.forEach(zone => {
  const target = zone.querySelector('.dnd-zone-target');
  target.addEventListener('dragover', (e) => { e.preventDefault(); target.classList.add('drag-over'); });
  target.addEventListener('dragleave', () => target.classList.remove('drag-over'));
  target.addEventListener('drop', (e) => {
    e.preventDefault();
    target.classList.remove('drag-over');
    const answer = e.dataTransfer.getData('text/plain');
    const chip = document.querySelector(`[data-answer="${answer}"]`);
    target.textContent = chip.textContent;
    target.dataset.placed = answer;
    chip.classList.add('placed');
  });
});

// TOUCH: Custom implementation (HTML5 drag doesn't work on mobile)
chips.forEach(chip => {
  chip.addEventListener('touchstart', (e) => {
    e.preventDefault();
    const touch = e.touches[0];
    const clone = chip.cloneNode(true);
    clone.classList.add('touch-ghost');
    clone.style.cssText = `position:fixed; z-index:1000; pointer-events:none;
      left:${touch.clientX - 40}px; top:${touch.clientY - 20}px;`;
    document.body.appendChild(clone);
    chip._ghost = clone;
    chip._answer = chip.dataset.answer;
  }, { passive: false });

  chip.addEventListener('touchmove', (e) => {
    e.preventDefault();
    const touch = e.touches[0];
    if (chip._ghost) {
      chip._ghost.style.left = (touch.clientX - 40) + 'px';
      chip._ghost.style.top = (touch.clientY - 20) + 'px';
    }
    // Highlight zone under finger
    const el = document.elementFromPoint(touch.clientX, touch.clientY);
    zones.forEach(z => z.querySelector('.dnd-zone-target').classList.remove('drag-over'));
    if (el && el.closest('.dnd-zone-target')) {
      el.closest('.dnd-zone-target').classList.add('drag-over');
    }
  }, { passive: false });

  chip.addEventListener('touchend', (e) => {
    if (chip._ghost) { chip._ghost.remove(); chip._ghost = null; }
    const touch = e.changedTouches[0];
    const el = document.elementFromPoint(touch.clientX, touch.clientY);
    if (el && el.closest('.dnd-zone-target')) {
      const target = el.closest('.dnd-zone-target');
      target.textContent = chip.textContent;
      target.dataset.placed = chip._answer;
      chip.classList.add('placed');
    }
  });
});
```

---

## Group Chat Animation

iMessage/WeChat-style chat showing components "talking" to each other. Messages appear one by one with typing indicators.

**Wiring:** `main.js` auto-initializes every `.chat-window` on page load. Give each chat window a unique `id`. Control buttons need these classes: `.chat-next-btn`, `.chat-all-btn`, `.chat-reset-btn`. The typing indicator avatar element should have `id="{chatWindowId}-typing-avatar"` or simply be the first `.chat-avatar` inside `.chat-typing`.

**HTML:**
```html
<div class="chat-window" id="chat-module2">
  <div class="chat-messages">
    <div class="chat-message" data-msg="0" data-sender="actor-a" style="display:none">
      <div class="chat-avatar" style="background: var(--color-actor-1)">A</div>
      <div class="chat-bubble">
        <span class="chat-sender" style="color: var(--color-actor-1)">角色 A</span>
        <p>喂，后台，把这条数据给我。</p>
      </div>
    </div>
    <!-- more messages... -->
  </div>

  <div class="chat-typing" id="chat-typing" style="display:none">
    <div class="chat-avatar" id="typing-avatar">?</div>
    <div class="chat-typing-dots">
      <span class="typing-dot"></span>
      <span class="typing-dot"></span>
      <span class="typing-dot"></span>
    </div>
  </div>

  <div class="chat-controls">
    <button class="btn chat-next-btn">下一条消息</button>
    <button class="btn chat-all-btn">全部播放</button>
    <button class="btn chat-reset-btn">重播</button>
    <span class="chat-progress"></span>
  </div>
</div>
```

**CSS for typing dots:**
```css
.typing-dot {
  width: 8px; height: 8px; border-radius: 50%;
  background: var(--color-text-muted);
  animation: typingBounce 1.4s infinite;
}
.typing-dot:nth-child(2) { animation-delay: 0.2s; }
.typing-dot:nth-child(3) { animation-delay: 0.4s; }
@keyframes typingBounce {
  0%, 60%, 100% { transform: translateY(0); }
  30% { transform: translateY(-6px); }
}
```

---

## Message Flow / Data Flow Animation

Step-by-step visualization of data moving between components. User clicks 「下一步」 to advance.

**Wiring:** `main.js` auto-initializes every `.flow-animation` on page load. Pass steps as JSON in `data-steps`. Each step object: `{ highlight: "flow-actor-id", label: "description", packet: true, from: "actor-id-suffix", to: "actor-id-suffix" }`. Actor element IDs must be `flow-actor-1`, `flow-actor-2`, etc. Control buttons need classes `.flow-next-btn` and `.flow-reset-btn`.

> **⚠️ Single quotes in step labels will break parsing.** The `data-steps` attribute is delimited by single quotes (`data-steps='[...]'`), so any single quote inside a label (e.g. `"the user's request"`) will terminate the attribute early and cause `JSON.parse` to fail silently — the entire animation will stop working. Either avoid apostrophes in labels, replace them with `&apos;`, or rewrite the attribute using double-quote delimiters with escaped inner quotes (`data-steps="[{\"label\":\"...\"}]"`).

**HTML:**
```html
<div class="flow-animation" data-steps='[
  {"highlight":"flow-actor-1","label":"用户点击按钮"},
  {"highlight":"flow-actor-1","label":"前端把请求发出去","packet":true,"from":"actor-1","to":"actor-2"},
  {"highlight":"flow-actor-2","label":"后端去调用数据库","packet":true,"from":"actor-2","to":"actor-3"}
]'>
  <div class="flow-actors">
    <div class="flow-actor" id="flow-actor-1">
      <div class="flow-actor-icon">A</div>
      <span>角色 1</span>
    </div>
    <div class="flow-actor" id="flow-actor-2">
      <div class="flow-actor-icon">B</div>
      <span>角色 2</span>
    </div>
    <div class="flow-actor" id="flow-actor-3">
      <div class="flow-actor-icon">C</div>
      <span>角色 3</span>
    </div>
  </div>

  <div class="flow-packet" id="flow-packet"></div>

  <div class="flow-step-label" id="flow-label">点击「下一步」开始</div>

  <div class="flow-controls">
    <button class="btn flow-next-btn">下一步</button>
    <button class="btn flow-reset-btn">重新开始</button>
    <span class="flow-progress"></span>
  </div>
</div>
```

**CSS for active actor glow:**
```css
.flow-actor.active {
  box-shadow: 0 0 0 3px var(--color-accent), 0 0 20px rgba(217, 79, 48, 0.2);
  transform: scale(1.05);
  transition: all var(--duration-normal) var(--ease-out);
}
```

---

## Interactive Architecture Diagram

Full-system diagram where hovering/clicking a component shows a description tooltip.

**HTML:**
```html
<div class="arch-diagram">
  <div class="arch-zone arch-zone-browser">
    <h4 class="arch-zone-label">浏览器</h4>
    <div class="arch-component" data-desc="往网页里注入界面、读取 DOM、捕捉用户操作"
         onclick="showArchDesc(this)">
      <div class="arch-icon">📄</div>
      <span>组件 A</span>
    </div>
    <!-- more components -->
  </div>
  <div class="arch-zone arch-zone-external">
    <h4 class="arch-zone-label">外部服务</h4>
    <!-- API cards -->
  </div>
  <div class="arch-description" id="arch-desc">点击任意组件，看看它负责什么</div>
</div>
```

---

## Layer Toggle Demo

Shows how different layers (e.g., HTML/CSS/JS, or data/logic/UI) build on each other. Three tabs switch between views.

**HTML:**
```html
<div class="layer-demo">
  <div class="layer-tabs">
    <button class="layer-tab active" onclick="showLayer('html')">HTML</button>
    <button class="layer-tab" onclick="showLayer('css')">+ CSS</button>
    <button class="layer-tab" onclick="showLayer('js')">+ JS</button>
  </div>
  <div class="layer-viewport">
    <div class="layer" id="layer-html" style="display:block">
      <!-- Raw unstyled version -->
    </div>
    <div class="layer" id="layer-css" style="display:none">
      <!-- Styled version -->
    </div>
    <div class="layer" id="layer-js" style="display:none">
      <!-- Interactive version -->
    </div>
  </div>
  <p class="layer-description" id="layer-desc">这是最原始的 HTML……</p>
</div>
```

---

## "Spot the Bug" Challenge

Show code with a deliberate bug. User clicks the buggy line. Reveal explains the issue.

**HTML:**
```html
<div class="bug-challenge">
  <h3>点击你认为有问题的代码行：</h3>
  <div class="bug-code">
    <div class="bug-line" data-line="1" onclick="checkBugLine(this, false)">
      <span class="line-num">1</span>
      <code>chrome.runtime.onMessage.addListener((msg, sender, sendResponse) => {</code>
    </div>
    <div class="bug-line" data-line="2" onclick="checkBugLine(this, false)">
      <span class="line-num">2</span>
      <code>  if (msg.action === 'fetchData') {</code>
    </div>
    <div class="bug-line bug-target" data-line="3" onclick="checkBugLine(this, true)">
      <span class="line-num">3</span>
      <code>    fetch(url).then(r => r.json()).then(data => sendResponse(data));</code>
    </div>
    <div class="bug-line" data-line="4" onclick="checkBugLine(this, false)">
      <span class="line-num">4</span>
      <code>  }</code>
    </div>
    <div class="bug-line" data-line="5" onclick="checkBugLine(this, false)">
      <span class="line-num">5</span>
      <code>});</code>
    </div>
  </div>
  <div class="bug-feedback" id="bug-feedback"></div>
</div>
```

**JS:**
```javascript
window.checkBugLine = function(el, isCorrect) {
  const feedback = el.closest('.bug-challenge').querySelector('.bug-feedback');
  if (isCorrect) {
    el.classList.add('correct');
    feedback.innerHTML = '<strong>找到了！</strong> 这个监听器用了异步操作（fetch），却没有 return true。Chrome 会在响应真正发出去之前就把消息通道关掉。修法：在最后加上 <code>return true;</code>。';
    feedback.className = 'bug-feedback show success';
  } else {
    el.classList.add('incorrect');
    feedback.innerHTML = '不是这一行——注意哪里可能因为异步的时序出问题……';
    feedback.className = 'bug-feedback show error';
    setTimeout(() => { el.classList.remove('incorrect'); feedback.className = 'bug-feedback'; }, 2000);
  }
};
```

---

## Scenario Quiz

"What would a senior engineer do?" — situational questions with explanations.

Same HTML/CSS/JS pattern as Multiple-Choice Quizzes, but with longer scenario descriptions and more detailed explanations. Wrap each question in a scenario context block:

```html
<div class="scenario-block">
  <div class="scenario-context">
    <span class="scenario-label">场景</span>
    <p>你的应用要处理一份 3 小时的播客转录稿，而接口有 16000 个 token 的上限。你会怎么做？</p>
  </div>
  <!-- quiz-options here -->
</div>
```

---

## Callout Boxes

"Aha!" moments — universal CS insights. Max 2 per module.

```html
<div class="callout callout-accent">
  <div class="callout-icon">💡</div>
  <div class="callout-content">
    <strong class="callout-title">关键洞察</strong>
    <p>把职责拆成各司其职的几个角色，是软件工程里最重要的思想之一，工程师管它叫「关注点分离（separation of concerns）」。</p>
  </div>
</div>
```

**Variants:**
- `callout-accent`: vermillion left border, light accent background (for CS insights)
- `callout-info`: teal left border, light info background (for "good to know")
- `callout-warning`: red left border, light error background (for common mistakes)

---

## Pattern/Feature Cards

Grid of cards highlighting engineering patterns, tech stack components, or key concepts.

```html
<div class="pattern-cards">
  <div class="pattern-card" style="border-top: 3px solid var(--color-actor-1)">
    <div class="pattern-icon" style="background: var(--color-actor-1)">🔄</div>
    <h4 class="pattern-title">缓存（caching）</h4>
    <p class="pattern-desc">把结果存起来，避免重复劳动——就像把剩菜留着，而不是每顿都从头做一遍。</p>
  </div>
  <!-- more cards -->
</div>
```

```css
.pattern-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: var(--space-4);
}
.pattern-card {
  background: var(--color-surface);
  border-radius: var(--radius-md);
  padding: var(--space-6);
  box-shadow: var(--shadow-sm);
  transition: transform var(--duration-normal) var(--ease-out), box-shadow var(--duration-normal);
}
.pattern-card:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-md);
}
```

---

## Flow Diagrams

**Horizontal flow (desktop):**
```html
<div class="flow-steps">
  <div class="flow-step">
    <div class="flow-step-num">1</div>
    <p>用户点击按钮</p>
  </div>
  <div class="flow-arrow">→</div>
  <div class="flow-step">
    <div class="flow-step-num">2</div>
    <p>组件 A 捕捉到点击</p>
  </div>
  <div class="flow-arrow">→</div>
  <!-- more steps -->
</div>
```

Arrows rotate to `↓` on mobile via CSS transform.

---

## Permission/Config Badges

For annotating config files, permissions, or settings:

```html
<div class="badge-list">
  <div class="badge-item">
    <code class="badge-code">storage</code>
    <span class="badge-desc">跨会话保存数据（就像浏览器的书签）</span>
  </div>
  <div class="badge-item">
    <code class="badge-code">activeTab</code>
    <span class="badge-desc">访问当前打开的标签页（只在用户点击时才有权限）</span>
  </div>
</div>
```

```css
.badge-item {
  display: flex; align-items: center; gap: var(--space-4);
  padding: var(--space-3) var(--space-4);
  border: 1px solid var(--color-border-light);
  border-radius: var(--radius-sm);
  transition: border-color var(--duration-fast);
}
.badge-item:hover { border-color: var(--color-accent-muted); }
.badge-code {
  font-family: var(--font-mono);
  font-size: var(--text-sm);
  background: var(--color-bg-code);
  color: #CBA6F7;
  padding: var(--space-1) var(--space-3);
  border-radius: var(--radius-sm);
  white-space: nowrap;
}
```

---

## Glossary Tooltips

The most important accessibility feature for non-technical learners. Any technical term in the course text should be wrapped in a tooltip that shows a plain-Chinese definition on hover (desktop) or tap (mobile). The learner never has to leave the page or Google anything. 术语解释用中文写，术语本身首次出现时写成「中文（English）」。

**HTML — mark up terms inline:**
```html
<p>这个浏览器扩展用一个
  <span class="term" data-definition="Service Worker（服务工作线程）是一段独立于网页运行的后台脚本——就像一位常驻的幕后助理，即使你没在看这个页面，它也一直在待命。">Service Worker</span>
  来处理接口调用。
</p>
```

**CSS:**
```css
.term {
  border-bottom: 1.5px dashed var(--color-accent-muted);
  cursor: pointer;    /* NOT cursor: help — pointer feels clickable and inviting */
  position: relative;
}
.term:hover, .term.active {
  border-bottom-color: var(--color-accent);
  color: var(--color-accent);
}

/* The tooltip bubble — uses position: fixed and is appended to document.body
   via JS so it is NEVER clipped by ancestor overflow: hidden containers
   (like translation blocks). See JS section below for positioning logic. */
.term-tooltip {
  position: fixed;        /* CRITICAL: fixed, not absolute — prevents clipping */
  background: var(--color-bg-code);
  color: #CDD6F4;
  padding: var(--space-3) var(--space-4);
  border-radius: var(--radius-sm);
  font-size: var(--text-sm);
  font-family: var(--font-body);
  line-height: var(--leading-normal);
  width: max(200px, min(320px, 80vw));
  box-shadow: var(--shadow-lg);
  pointer-events: none;
  opacity: 0;
  transition: opacity var(--duration-fast);
  z-index: 10000;        /* Above everything, including nav */
}
/* Arrow pointing down */
.term-tooltip::after {
  content: '';
  position: absolute;
  top: 100%;
  left: 50%;
  transform: translateX(-50%);
  border: 6px solid transparent;
  border-top-color: var(--color-bg-code);
}
.term-tooltip.visible {
  opacity: 1;
}

/* If tooltip goes off-screen top, flip to below */
.term-tooltip.flip {
  bottom: auto;
  top: calc(100% + 8px);
}
.term-tooltip.flip::after {
  top: auto;
  bottom: 100%;
  border-top-color: transparent;
  border-bottom-color: var(--color-bg-code);
}
```

**JS — position: fixed tooltips appended to body (never clipped by overflow):**
```javascript
// Tooltip container — appended to body so it's never clipped
let activeTooltip = null;

function positionTooltip(term, tip) {
  const rect = term.getBoundingClientRect();
  const tipWidth = 300; // approximate
  let left = rect.left + rect.width / 2 - tipWidth / 2;
  // Clamp to viewport
  left = Math.max(8, Math.min(left, window.innerWidth - tipWidth - 8));

  // Try above first
  let top = rect.top - 8;
  tip.style.left = left + 'px';

  // Position above by default, flip below if no room
  document.body.appendChild(tip);
  const tipHeight = tip.offsetHeight;
  if (rect.top - tipHeight - 8 < 0) {
    // Flip below
    tip.style.top = (rect.bottom + 8) + 'px';
    tip.classList.add('flip');
  } else {
    tip.style.top = (rect.top - tipHeight - 8) + 'px';
    tip.classList.remove('flip');
  }
}

document.querySelectorAll('.term').forEach(term => {
  const tip = document.createElement('span');
  tip.className = 'term-tooltip';
  tip.textContent = term.dataset.definition;

  // Hover for desktop
  term.addEventListener('mouseenter', () => {
    if (activeTooltip && activeTooltip !== tip) {
      activeTooltip.classList.remove('visible');
      activeTooltip.remove();
    }
    positionTooltip(term, tip);
    requestAnimationFrame(() => tip.classList.add('visible'));
    activeTooltip = tip;
  });

  term.addEventListener('mouseleave', () => {
    tip.classList.remove('visible');
    setTimeout(() => { if (!tip.classList.contains('visible')) tip.remove(); }, 150);
    activeTooltip = null;
  });

  // Tap for mobile
  term.addEventListener('click', (e) => {
    e.stopPropagation();
    if (activeTooltip && activeTooltip !== tip) {
      activeTooltip.classList.remove('visible');
      activeTooltip.remove();
    }
    if (tip.classList.contains('visible')) {
      tip.classList.remove('visible');
      tip.remove();
      activeTooltip = null;
    } else {
      positionTooltip(term, tip);
      requestAnimationFrame(() => tip.classList.add('visible'));
      activeTooltip = tip;
    }
  });
});

// Close tooltips when clicking elsewhere
document.addEventListener('click', () => {
  if (activeTooltip) {
    activeTooltip.classList.remove('visible');
    activeTooltip.remove();
    activeTooltip = null;
  }
});
```

**Rules:**
- 每个模块里，每一个技术术语第一次出现时都要加气泡（API、DOM、回调、异步、接口端点、中间件……）
- 定义控制在 1-2 句话，用大白话，不要用另一个术语解释术语
- 能用比喻就用比喻——例如「**回调（callback）**就像在餐厅留下手机号，位子好了他们会打给你」
- 同一个屏幕里不要重复标注同一个术语——每个模块只在首次出现处标注
- 下划虚线要低调但不隐形：不干扰阅读，又能让好奇的学习者发现它可以点

---

## Visual File Tree

Use instead of paragraphs listing "this folder does X, that folder does Y." Much easier to scan.

```html
<div class="file-tree">
  <div class="ft-folder open">
    <span class="ft-name">app/</span>
    <span class="ft-desc">页面和接口路由</span>
    <div class="ft-children">
      <div class="ft-folder">
        <span class="ft-name">api/</span>
          <span class="ft-desc">前端会调用的后端接口</span>
      </div>
      <div class="ft-file">
        <span class="ft-name">layout.tsx</span>
        <span class="ft-desc">包住每个页面的外壳</span>
      </div>
    </div>
  </div>
  <div class="ft-folder">
    <span class="ft-name">components/</span>
    <span class="ft-desc">可复用的界面积木</span>
  </div>
  <div class="ft-folder">
    <span class="ft-name">lib/</span>
    <span class="ft-desc">共享的逻辑和工具函数</span>
  </div>
</div>
```

```css
.file-tree { font-family: var(--font-mono); font-size: var(--text-sm); }
.ft-folder, .ft-file {
  padding: var(--space-2) var(--space-3);
  border-left: 2px solid var(--color-border-light);
  margin-left: var(--space-4);
}
.ft-folder > .ft-name { color: var(--color-accent); font-weight: 600; }
.ft-folder > .ft-name::before { content: '📁 '; }
.ft-file > .ft-name::before { content: '📄 '; }
.ft-desc {
  color: var(--color-text-secondary);
  font-family: var(--font-body);
  margin-left: var(--space-2);
  font-size: var(--text-xs);
}
.ft-children { margin-left: var(--space-4); }
```

---

## Icon-Label Rows

For listing components, features, or concepts visually. Replaces bullet-point paragraphs.

```html
<div class="icon-rows">
  <div class="icon-row">
    <div class="icon-circle" style="background: var(--color-actor-1)">🖥️</div>
    <div>
      <strong>前端（Next.js）</strong>
      <p>用户看到并直接操作的那一层</p>
    </div>
  </div>
  <div class="icon-row">
    <div class="icon-circle" style="background: var(--color-actor-2)">⚡</div>
    <div>
      <strong>接口路由（API Routes）</strong>
      <p>跑在服务器上的后端逻辑</p>
    </div>
  </div>
  <div class="icon-row">
    <div class="icon-circle" style="background: var(--color-actor-3)">🗄️</div>
    <div>
      <strong>数据库（Supabase）</strong>
      <p>所有数据长期存放的地方</p>
    </div>
  </div>
</div>
```

```css
.icon-rows { display: flex; flex-direction: column; gap: var(--space-4); }
.icon-row {
  display: flex; align-items: center; gap: var(--space-4);
  padding: var(--space-4);
  background: var(--color-surface);
  border-radius: var(--radius-md);
  box-shadow: var(--shadow-sm);
}
.icon-row p { margin: 0; color: var(--color-text-secondary); font-size: var(--text-sm); }
.icon-circle {
  width: 48px; height: 48px; border-radius: 50%;
  display: flex; align-items: center; justify-content: center;
  font-size: 1.25rem; flex-shrink: 0;
}
```

---

## Numbered Step Cards

For sequences that would otherwise be a numbered paragraph list. Visual, scannable, and each step stands alone.

```html
<div class="step-cards">
  <div class="step-card">
    <div class="step-num">1</div>
    <div class="step-body">
      <strong>用户粘贴一个 YouTube 链接</strong>
      <p>前端接住这个链接，并从中提取出视频 ID</p>
    </div>
  </div>
  <div class="step-card">
    <div class="step-num">2</div>
    <div class="step-body">
      <strong>接口去取字幕</strong>
      <p>一个服务端路由调用外部服务，拿到视频的文字内容</p>
    </div>
  </div>
  <div class="step-card">
    <div class="step-num">3</div>
    <div class="step-body">
      <strong>AI 分析内容</strong>
      <p>这份文字稿被送进 AI 模型，由它挑出关键片段</p>
    </div>
  </div>
</div>
```

```css
.step-cards { display: flex; flex-direction: column; gap: var(--space-3); }
.step-card {
  display: flex; align-items: flex-start; gap: var(--space-4);
  padding: var(--space-4) var(--space-5);
  background: var(--color-surface);
  border-radius: var(--radius-md);
  border-left: 3px solid var(--color-accent);
  box-shadow: var(--shadow-sm);
}
.step-num {
  width: 32px; height: 32px; border-radius: 50%;
  background: var(--color-accent);
  color: white; font-weight: 700;
  display: flex; align-items: center; justify-content: center;
  font-family: var(--font-display);
  flex-shrink: 0;
}
.step-body p { margin: var(--space-1) 0 0; color: var(--color-text-secondary); font-size: var(--text-sm); }
```
