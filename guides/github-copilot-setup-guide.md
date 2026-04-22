# GitHub Copilot 完整搭建教程（精细版）

> 在个人电脑的 VSCode 上搭建类似公司 Vibe-Coding 体验的 AI 编程助手  
> 方案：**GitHub Copilot + Copilot Chat + Copilot CLI**

---

## 📋 准备工作

**你需要：**
- 一台电脑（Windows / macOS / Linux 均可）
- 可以访问 GitHub 的网络环境（国内用户可能需要科学上网）
- 一张信用卡 / PayPal（用于订阅，学生可免费）

---

## 🔹 第一步：注册 / 登录 GitHub 账号

1. 打开浏览器访问：**https://github.com**
2. 右上角点击 **Sign up**（注册）或 **Sign in**（登录）
3. 注册需要填：
   - **Username**（用户名，以后会用到）
   - **Email**（邮箱）
   - **Password**（密码）
4. 完成邮箱验证码验证

---

## 🔹 第二步：开通 GitHub Copilot 订阅

### 方式 A：付费订阅（$10/月 或 $100/年）

1. 登录后访问：**https://github.com/settings/copilot**
2. 点击页面上的 **Start free trial**（免费试用 30 天）或 **Get Copilot**
3. 选择套餐：
   - **Copilot Individual** — $10/月（个人够用）
   - **Copilot Pro** — $10/月（包含 Chat）
   - **Copilot Pro+** — $39/月（更多高级模型额度）
4. 点击 **Continue** → 填写信用卡信息 → 确认订阅
5. 订阅设置页面会询问几个选项，**建议按以下设置**：
   - `Suggestions matching public code` → **Allow**（允许匹配公开代码）
   - `Allow GitHub to use my code snippets for product improvements` → **根据个人偏好**（建议关闭，更隐私）
   - 点击 **Save**

### 方式 B：免费获取（学生 / 教师 / 开源维护者）

1. 访问：**https://education.github.com/pack**
2. 点击 **Sign up for Student Developer Pack**
3. 上传学生证明（学生证、在读证明、学校邮箱等）
4. 通常 1-7 天审核通过，通过后 Copilot 自动免费

### 方式 C：免费版（2024 年底推出，额度有限）

访问 **https://github.com/features/copilot** → 直接登录即可使用（每月有限额度）

---

## 🔹 第三步：安装 VSCode（已安装可跳过）

1. 访问：**https://code.visualstudio.com/**
2. 点击 **Download**，根据你的系统选择安装包
3. 双击运行安装程序，一路 **Next** 完成安装
4. 打开 VSCode

---

## 🔹 第四步：在 VSCode 安装 Copilot 扩展

1. 打开 VSCode
2. 左侧边栏点击 **Extensions** 图标（四个方块，或按快捷键 `Ctrl+Shift+X` / `Cmd+Shift+X`）
3. 在搜索框输入：**GitHub Copilot**
4. 找到 **GitHub Copilot**（作者：GitHub），点击 **Install**
5. 安装完后，再搜索：**GitHub Copilot Chat**
6. 点击 **Install**（这是对话功能，必装）

> 💡 两个扩展都装完后，VSCode 右下角会弹出登录提示。

---

## 🔹 第五步：在 VSCode 登录 GitHub

1. VSCode 右下角会出现 **Sign in to GitHub** 提示 → 点击

   如果没弹出：按 `Ctrl+Shift+P`（Mac: `Cmd+Shift+P`）打开命令面板，输入并选择 **GitHub Copilot: Sign In**

2. 会弹出：**"Allow extension to sign in using GitHub?"** → 点击 **Allow**
3. 浏览器自动打开 GitHub 授权页 → 点击 **Authorize Visual Studio Code**
4. 浏览器提示 **"打开 Visual Studio Code?"** → 点击 **打开**
5. VSCode 右下角显示 **"GitHub Copilot is ready"** ✅

---

## 🔹 第六步：验证 Copilot 正常工作

### 测试 1：代码补全
1. 新建一个文件 `test.py`
2. 输入注释：
   ```python
   # 写一个计算斐波那契数列的函数
   ```
3. 按回车后应该出现**灰色建议代码**
4. 按 `Tab` 接受建议

### 测试 2：Chat 对话
1. 按 `Ctrl+Alt+I`（Mac: `Cmd+Ctrl+I`）打开 Copilot Chat 面板
2. 或者左侧边栏点击 **Chat 图标**（💬）
3. 输入：`帮我写一个快速排序` → 回车
4. 应该有 AI 回复 ✅

---

## 🔹 第七步：安装 Copilot CLI（终端使用，类似你公司的体验）

这一步是关键，让你能在**终端**里像你现在用的一样使用。

### 前置：安装 Node.js

**检查是否已安装：**
```bash
node --version
```
如果显示 `v18.0.0` 或更高版本，跳过安装。

**未安装则：**
- 访问 **https://nodejs.org/** → 下载 **LTS 版本** → 安装（一路 Next）
- 安装完重启终端，再次运行 `node --version` 验证

### 安装 Copilot CLI

打开终端（VSCode 里按 `` Ctrl+` `` 打开内置终端），输入：

```bash
npm install -g @github/copilot
```

> 如果 macOS/Linux 报权限错误，用：`sudo npm install -g @github/copilot`

安装完成后，运行：

```bash
copilot
```

首次运行会：
1. 提示登录 → 按提示复制一个**设备码**（如 `ABCD-1234`）
2. 浏览器自动打开或提示你访问 **https://github.com/login/device**
3. 粘贴设备码 → 点击 **Continue** → **Authorize**
4. 回到终端，显示登录成功 ✅

### 使用 Copilot CLI

进入任何项目目录，输入：
```bash
copilot
```

然后用自然语言对话，比如：
```
帮我创建一个 Express 服务器，监听 3000 端口
```

它会**自动读写文件、执行命令**，和你现在用的一模一样。

---

## 🔹 第八步（可选）：常用快捷键与配置

### VSCode 中 Copilot 常用快捷键

| 操作 | Windows/Linux | macOS |
|------|---------------|-------|
| 接受建议 | `Tab` | `Tab` |
| 拒绝建议 | `Esc` | `Esc` |
| 下一条建议 | `Alt+]` | `Option+]` |
| 上一条建议 | `Alt+[` | `Option+[` |
| 打开 Chat | `Ctrl+Alt+I` | `Cmd+Ctrl+I` |
| 内联 Chat（编辑器内） | `Ctrl+I` | `Cmd+I` |

### 切换模型（Pro 及以上）

在 Chat 面板底部点击模型名称（如 `GPT-4o`），可切换为 **Claude Sonnet 4.5** 等。代码任务推荐 **Claude Sonnet**。

### 启用 Agent 模式（自动改代码、跑命令）

1. Chat 面板顶部下拉菜单选择 **Agent**（而不是 Ask / Edit）
2. 这是最接近你公司 vibe-coding 体验的模式，能自动执行多步骤任务

---

## ✅ 搭建完成检查清单

- [ ] GitHub 账号已开通 Copilot 订阅
- [ ] VSCode 安装了 `GitHub Copilot` + `GitHub Copilot Chat` 两个扩展
- [ ] VSCode 内能看到代码灰色补全建议
- [ ] Copilot Chat 面板能正常对话
- [ ] 终端里 `copilot` 命令可用
- [ ] Chat 能切换到 **Agent 模式**

---

## 🆘 常见问题

**Q1: VSCode 一直显示 "Sign in" 登录不上？**
- 检查网络是否能访问 github.com
- 尝试命令面板运行 `GitHub Copilot: Sign Out` 后重新登录

**Q2: 终端 `copilot` 命令找不到？**
- 重启终端
- 检查 npm 全局路径：`npm config get prefix`，确保其 `bin` 目录在 `PATH` 中

**Q3: 补全没反应？**
- 右下角状态栏看 Copilot 图标，点开看是否启用
- 确认订阅未过期：https://github.com/settings/copilot

**Q4: 国内访问慢？**
- Copilot 服务需要稳定访问 github.com 和 api.githubcopilot.com
- 建议配置科学上网，或使用终端代理

---

> 📝 本指南由 Copilot CLI 协助整理生成
