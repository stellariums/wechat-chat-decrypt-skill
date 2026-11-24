<!-- Modified by stellariums for this adaptation. -->

# Windows verification notes

The verified Windows route uses Weixin `4.1.8.101` and the SQLCipher v4 data under `xwechat_files/<account>/db_storage`.

- Preflight detects the app version, running processes, account directories and encrypted databases.
- Check database-page HMACs, then verify that at least one decrypted message database passes SQLite `quick_check`.
- Run a limited query to check access to local history for the selected account. A partial set of verified shards can yield partial results.
- Verify saved keys before running queries after an app update. A newer build can be unsupported for obtaining keys while earlier saved keys still match the local databases.
- The safe query wrapper removes temporary plaintext on exit. Use `cleanup --include-probes` to check for and remove leftovers.

Report the version, compatibility, aggregate verification status and cleanup status. Keep account identifiers, device paths, raw diagnostic logs, and key files private.
