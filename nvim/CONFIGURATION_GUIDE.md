# AstroNvim 配置说明文档

## 📋 概述
这是基于 AstroNvim v5+ 的 Neovim 配置，提供了现代化的编辑器体验。

## 📁 目录结构
```
nvim/
├── init.lua              # 🚀 启动入口文件
├── lua/
│   ├── lazy_setup.lua    # 📦 Lazy.nvim 插件管理器配置
│   ├── community.lua     # 🌍 社区插件配置（需手动激活）
│   ├── polish.lua        # ✨ 自定义配置文件（需手动激活）
│   └── plugins/          # 🔧 插件配置目录
│       ├── astrocore.lua # ⚙️  核心功能配置（✅已启用）
│       ├── astrolsp.lua  # 💡 LSP语言服务器配置（需手动激活）
│       ├── astroui.lua   # 🎨 UI界面配置（需手动激活）
│       ├── mason.lua     # 📦 工具包管理器配置（需手动激活）
│       ├── treesitter.lua# 🌈 语法高亮配置（需手动激活）
│       ├── none-ls.lua   # 🔍 格式化和诊断工具
│       └── user.lua      # 👤 用户自定义插件（需手动激活）
├── README.md             # 📖 原始英文说明
├── neovim.yml           # 🔄 GitHub Actions配置
└── selene.toml          # 🧹 Lua代码检查配置
```

## 🔧 核心配置详解

### 1. 启动配置 (init.lua)
- **功能**: 自动引导安装 Lazy.nvim 插件管理器
- **加载顺序**: lazy_setup → polish
- **错误处理**: 包含完整的错误检查和用户提示

### 2. 插件管理 (lazy_setup.lua)
- **Leader 键**: `<Space>` (空格键)
- **Local Leader 键**: `,` (逗号键)
- **图标支持**: 默认启用 (需要 Nerd Font)
- **默认主题**: astrotheme + habamax 备选
- **性能优化**: 禁用部分内置插件

### 3. 核心功能 (astrocore.lua) ✅
**状态**: 已启用

**主要功能**:
- 大文件处理限制 (256KB/10000行)
- 自动配对、补全、诊断功能
- URL 高亮和通知系统
- 相对行号和绝对行号显示
- 缓冲区导航快捷键配置

**重要配置**:
```lua
-- 基本选项
relativenumber = true  -- 相对行号
number = true         -- 绝对行号
wrap = false          -- 不换行
signcolumn = "yes"    -- 显示标记列

-- 快捷键
["]b"] -- 下一个缓冲区
["[b"] -- 上一个缓冲区
["<Leader>bd"] -- 关闭缓冲区
```

### 4. LSP 配置 (astrolsp.lua) 🔒
**状态**: 已禁用，需要删除第1行激活

**主要功能**:
- 代码镜头 (codelens) 支持
- 语义令牌高亮
- 保存时自动格式化
- 格式化超时设置 (1000ms)
- 自定义语言服务器配置

**重要设置**:
- 格式化超时: 1000ms
- 内联提示: 默认关闭
- 语义令牌: 默认开启

### 5. UI 配置 (astroui.lua) 🔒
**状态**: 已禁用，需要删除第1行激活

**主要功能**:
- 默认配色方案: `astrodark`
- LSP 加载动画图标
- 主题高亮自定义
- 图标配置

### 6. 工具管理 (mason.lua) 🔒
**状态**: 已禁用，需要删除第1行激活

**预装工具**:
- `lua-language-server` - Lua 语言服务器
- `stylua` - Lua 代码格式化工具
- `debugpy` - Python 调试器
- `tree-sitter-cli` - 语法解析器

### 7. 语法高亮 (treesitter.lua) 🔒
**状态**: 已禁用，需要删除第1行激活

**预装解析器**:
- `lua` - Lua 语言支持
- `vim` - Vim 脚本支持

### 8. 社区插件 (community.lua) 🔒
**状态**: 已禁用，需要删除第1行激活

**包含内容**:
- AstroCommunity 插件集合
- Lua 语言包支持

### 9. 用户插件 (user.lua) 🔒
**状态**: 已禁用，需要删除第1行激活

**示例插件**:
- Discord 状态显示
- LSP 签名帮助
- 自定义仪表板
- 代码片段扩展
- 自动配对规则

## 🚀 快速启用配置

### 方法一: 全部激活
```bash
# 删除所有保护行
sed -i '1d' lua/community.lua
sed -i '1d' lua/polish.lua
# sed -i '1d' lua/plugins/astrocore.lua  # ✅ 已完成
sed -i '1d' lua/plugins/astrolsp.lua
sed -i '1d' lua/plugins/astroui.lua
sed -i '1d' lua/plugins/mason.lua
sed -i '1d' lua/plugins/treesitter.lua
sed -i '1d' lua/plugins/user.lua
```

### 方法二: 选择性激活
根据需要删除对应文件的第一行 `if true then return {} end`

## 📝 使用建议

### 1. 首次启动
```bash
nvim
```
- 会自动下载和安装插件
- 等待安装完成后重启

### 2. 常用命令
```vim
:LspInstall <server>     # 安装语言服务器
:TSInstall <language>    # 安装语法解析器
:DapInstall <debugger>   # 安装调试器
:Lazy update            # 更新插件
:Mason                  # 打开工具管理器
```

### 3. 基本快捷键
- `<Space>` - Leader 键
- `<Space>ff` - 查找文件
- `<Space>fg` - 全局搜索
- `<Space>bd` - 关闭缓冲区
- `]b` / `[b` - 缓冲区切换

## 🔧 自定义配置

### 添加新插件
在 `lua/plugins/user.lua` 中添加:
```lua
return {
  "plugin-author/plugin-name",
  config = function()
    -- 插件配置
  end,
}
```

### 修改快捷键
在 `lua/plugins/astrocore.lua` 的 `mappings` 部分添加:
```lua
mappings = {
  n = {
    ["<Leader>新键"] = { "命令", desc = "描述" },
  },
}
```

### 添加语言支持
1. 在 `mason.lua` 中添加语言服务器
2. 在 `treesitter.lua` 中添加语法解析器
3. 重启 nvim 并运行 `:Lazy sync`

## ⚠️ 注意事项

1. **需要 Neovim 0.10+**
2. **建议安装 Nerd Font** 以获得完整图标支持
3. **首次启动较慢** 因为需要下载插件
4. **备份现有配置** 避免配置冲突

## 🛠️ 故障排除

### 插件安装失败
```vim
:Lazy clean    # 清理插件
:Lazy sync     # 重新同步
```

### LSP 不工作
```vim
:LspInfo       # 查看 LSP 状态
:Mason         # 检查工具安装
```

### 主题显示异常
检查终端是否支持真彩色显示

---

💡 **提示**: 建议从核心配置开始逐步激活，确保每个功能都能正常工作后再启用更多插件。