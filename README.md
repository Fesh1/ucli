**UCLI: A Unified Command-Line Interface**

---

## 1. General Idea

UCLI is envisioned as a "highway" bridging UI/GUI, web, and terminal interfaces. It offers a single, consistent command-line layer through which applications expose and interact with data and functionality.

---

## 2. Why?

1. **Reduce Context Switching**: Today’s workflows span notes, planning tools, email, calendars, banking apps, and more. Constantly switching between UIs wastes time and mental energy.
2. **Simplify Complex Workflows**: Fifty years ago, planning your day meant juggling work, family, and sleep. Now, additional streams—social media, remote work, courses, bills, loans—make simple tasks unnecessarily complex.
3. **Leverage Muscle Memory**: Typing commands is faster and more efficient than mousing through graphical menus. Separating interaction (CLI) from perception (visual display) lets users navigate data by keyboard and view results visually only when needed.
4. **Deep Integration**: A unified interface encourages tight coupling between applications and interfaces, enabling powerful cross-application scripts and automations without bespoke UI work.

---

## 3. How It Works

* **CLI Foundation**: Core implementation atop standard shells (bash, zsh), enabling familiar patterns (pipes, redirection).
* **Data URIs**: Access resources via URI schemes (e.g., `gdrive:photos/${today}`, `monobank:/bank_statement?...`).
* **Security Layer**: Plugin hooks for authentication (OAuth, API keys) and granular permissions.
* **Developer SPI**: Standard plugin interface allowing apps to expose commands, arguments, and data models with minimal boilerplate.
* **Linguistic Layer**: Natural-language command aliases for ease of use (e.g., `chatgpt:'List F1 engineers'`).
* **Central Registry**: A `.pub` database of tools, commands, and schemas, discoverable by LLMs and CLIs alike.

---

## 4. Sources of Inspiration

* AppleScript
* Bash scripting tools (`yq`, `jq`, pipes)
* URI standards and conventions
* Cross-application standardization efforts
* Linguistic interfaces and DSL design
* Plugin/SPIs for extensibility

---

## 5. Examples

```bash
# View today's photos from Google Drive
show-command gdrive:photos/${today}

# Ask ChatGPT for a list of Formula 1 engineers
chatgpt:'Give me a list of Formula 1 engineers'

# Download bank statement, analyze spending
monobank:/bank_statement?start=today-7d,end=today,format=csv |
  chatgpt:'Generate a script to analyze my spending'

# Count last year's photos
chatgpt:'How many photos did I take last year with my main Google account?'
```

---

## 6. Roadmap

1. **Stage 1: Core CLI Prototype**

   * Implement a minimal shell wrapper supporting URI parsing and basic commands.
   * Define plugin API for registering commands and handlers.

2. **Stage 2: Data URI Connectors**

   * Build adapters for common services (Google Drive, local FS, sample banking API).
   * Demonstrate piping data between connectors and tools.

3. **Stage 3: Security and Authentication**

   * Integrate OAuth2 and API-key management.
   * Implement permission scopes and secure storage for credentials.

4. **Stage 4: Developer Ecosystem & Documentation**

   * Publish SPI documentation and starter SDKs (Python, Go).
   * Launch central registry (`.pub`) for community-contributed connectors.

5. **Stage 5: Advanced Integrations & LLM Support**

   * Add natural-language command layer powered by LLMs.
   * Develop auto-completion and context-aware suggestions in the shell.

6. **Stage 6: UI Visualization Layer**

   * Create optional GUI front-end for data browsing and interactive command construction.
   * Release desktop/web clients leveraging the UCLI core.


