# 微信聊天记录读取 Skill

[English](README.md)

让 Codex 按需读取本人电脑上的微信聊天记录。可以按会话、日期或关键词查消息，把约定整理成待办，也可以将指定会话导出为 Markdown。

## 安装

克隆仓库，运行对应平台的安装脚本，然后重启 Codex。安装脚本会为随仓库提供的 `wechat-cli` 建立独立的 Python 3.10 及以上运行环境。

**Windows PowerShell**

```powershell
git clone https://github.com/stellariums/wechat-chat-decrypt-skill.git
& .\wechat-chat-decrypt-skill\scripts\install-skill.ps1
```

**Apple Silicon macOS**

```bash
git clone https://github.com/stellariums/wechat-chat-decrypt-skill.git
bash ./wechat-chat-decrypt-skill/scripts/install-skill.sh
```

## 第一次使用

在 Codex 中调用 `$wechat-chat-decrypt`，按 [SKILL.md](SKILL.md) 操作。也可以直接使用[安装提示词](INSTALL_PROMPT.md)。

1. 预检平台、微信版本和本机账号。如果已有目标账号的密钥，先验证是否仍可复用。
2. 需要重新取密钥时，使用经验证的客户端版本。降级前备份本地聊天数据，修改微信或更新设置前先确认。
3. 用数据库页的 HMAC 和 SQLite 的 `quick_check` 验证消息库。再做一次范围有限的会话列表检查，确认查询链路能运行。
4. 按给定的会话、时间或关键词查询。每次通过安全包装脚本调用，临时明文库在命令结束时清理。

| 平台 | 已验证的取密钥版本 |
| --- | --- |
| Windows 10/11 | 微信 `4.1.8.101` |
| Apple Silicon macOS | 微信 `4.1.8`，构建号 `37261` |

升级微信后，已有密钥仍有可能打开当前数据库。先验证再复用，查询覆盖范围以实际结果为准。详见[兼容性说明](references/compatibility.md)与[故障排查](references/troubleshooting.md)。

## 使用示例

- “查项目群上周的聊天，看看我答应哪天发初稿。”
- “梳理这两个会话里从周一到现在交给我的事项，列出截止日期，拿不准的标为待确认。”
- “把指定的一个会话导成 Markdown，存到我指定的本机私有目录。”

可查范围取决于这台电脑存有哪些聊天，以及哪些数据库能通过验证。语音和图片需要单独处理。

## 本机数据与脱敏

数据库读取、密钥存储和临时解密都在本机完成。若使用云端 AI，进入对话或工具日志的内容可能会传到服务端。让云端模型协助分析时，先在本机整理并脱敏，只提供必要摘录或摘要。聊天原文、账号目录、密钥文件、备份和导出文件放在仓库外的私有位置。仓库示例使用通用名称和路径。

如需从 Git 检出目录生成可分享的 ZIP，提交后运行对应平台的 `scripts/package-skill` 打包脚本。压缩包取自已提交的 `HEAD`。

## 许可证与上游

使用 [Apache 2.0](LICENSE) 许可证。项目基于[原版微信聊天记录读取 Skill](https://github.com/chenchen1010/wechat-chat-decrypt-skill) 修改，并随仓库提供 `huohuoer/wechat-cli`。版本和来源见[第三方声明](THIRD_PARTY_NOTICES.md)。
