<!-- Modified by stellariums for this adaptation. -->

# WeChat Chat Decrypt Skill

[简体中文](README.zh-CN.md)

A Codex skill for searching the WeChat history stored on your own computer. Find messages by chat, date, or keyword, turn them into a task summary, or export a selected conversation as Markdown.

## Install

Clone this repository, run the installer for your platform, then restart Codex. The installer sets up a private Python 3.10+ environment for the bundled `wechat-cli`.

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

## First run

Ask Codex to use `$wechat-chat-decrypt` and follow [SKILL.md](SKILL.md). A full setup prompt is available in [INSTALL_PROMPT.md](INSTALL_PROMPT.md).

1. Run preflight to identify the platform, WeChat version, and local account. If saved keys exist for the intended account, verify them first.
2. When new keys are needed, use a verified client build. Back up the local chat data before a downgrade, and confirm any changes to the app or its update settings.
3. Verify a message database using database-page authentication (HMAC) and SQLite's `quick_check`. A limited session-list check can then confirm that the query path works.
4. Specify the chats, dates, or keywords to search. Use the safe wrapper for every query. Each command creates a private plaintext cache and cleans it up at exit.

| Platform | Verified build for obtaining new keys |
| --- | --- |
| Windows 10/11 | Weixin `4.1.8.101` |
| Apple Silicon macOS | WeChat `4.1.8`, build `37261` |

On a newer client, saved keys may still work against the current databases. Verify them before reuse and report query coverage based on what actually succeeds. See [compatibility](references/compatibility.md) and [troubleshooting](references/troubleshooting.md) for details.

## Example requests

- “Find which day I agreed to send a draft in Project Group last week.”
- “Summarize the tasks assigned to me in these two chats since Monday. Include due dates and flag uncertain items.”
- “Export one conversation to a private local Markdown file for review.”

The available history depends on which messages are stored on the computer and which databases can be read. Voice messages and images require separate processing.

## Privacy

Database access, key storage, and temporary decryption stay on your computer. If your AI assistant uses a hosted model, anything passed into its conversation or tool logs may leave the computer. For cloud-assisted analysis, use locally prepared, redacted excerpts or summaries. Keep raw exports, account directories, key files, and backups in private storage outside the repository. Examples in this repository use generic names and paths.

To build a shareable ZIP from a Git checkout, run the platform-specific `scripts/package-skill` script after committing. The archive contains files from the checkout's committed `HEAD`.

## License and upstream

Licensed under [Apache 2.0](LICENSE). This project adapts the [original WeChat Chat Decrypt Skill](https://github.com/chenchen1010/wechat-chat-decrypt-skill) and bundles `huohuoer/wechat-cli`. See [third-party notices](THIRD_PARTY_NOTICES.md) for versions and attribution.
