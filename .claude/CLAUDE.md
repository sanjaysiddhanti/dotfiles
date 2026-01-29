Follow this cycle for all that are easily amenable to tests:

1. **Write test + stubs** - Create failing test with minimal stub code
2. **Verify failure** - Run just that test (see Makefile; document method in CLAUDE.md if missing)
3. **Fix spurious results** - Iterate until test fails for the right reason
4. **Commit test** - `git commit` the test file only
5. **Implement** - Write code until test passes
6. **Handle test bugs** - If implementation reveals test issues: stash code, fix test, verify it fails, commit test fix, pop stash
7. **Commit implementation** - `git commit` the code changes

If it is not easily amenable to tests but can be tested via some bespoke method, mention how you verified that it works in the commit message.

When writing tests, strongly prefer integration tests which use databases. Do not mock out the database since it is easy to include it in the test suite using docker-compose.

If something needs fixing that is unrelated to what you are supposed to be working on, ask the user about it, but don't add TODO comments or make unnecessary drive-byfixes.


# Code styling

## Comments

- Avoid comments which just describe what the code is doing, especially if the code is straightforward. Name variables and functions clearly to make the code self-documenting.
- Focus comments on **why** rather than **what** - explain the reasoning, not the mechanics
- Never use temporal markers like "new", "improved", "legacy", "old", "deprecated", "TODO", "FIXME" in comments or variable names
  - These markers become outdated and create confusion about the current state of the code
  - If something is truly deprecated, remove it or use proper deprecation mechanisms

## Code organization

- Keep all imports at the top of the file
- Group imports in the standard order: stdlib, third-party, local
- Avoid scattered imports throughout the file

# Code standards

You can expect there is a Makefile (or makefile) which has a test target. This will almost always be something that builds a docker image and runs tests inside it. Do not expect you can run tests directly on your host machine.

Use `make test QUIET=true TESTS=...` to run individual tests. If this functionality does not already exist, create a subagent to add it.

# Git Safety Rules

- **Never use** `git add .`, `git add -A`, `git add --all`, or `git commit -a`
- **Always stage files explicitly** by name: `git add path/to/specific/file.py`
- Only commit files you directly created or modified for the current task
- ALWAYS check the diff before committing: `git diff --staged`. If there are changes you did not intend to include,
  DO NOT COMMIT, and ask for additional instructions. This is especially important for changes created by linters
  which are on lines or files you did not modify.

# Interactions with outside systems
When you are done with any task and asking for input, please run `post-slack "..."` with a message saying that you are either done or asking for input. Also do this before you try to run a command you're not authorized to run yet. Do not post command outputs directly to the message since that might contain sensitive information and keep the message brief
