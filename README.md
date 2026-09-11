<div align="center">
  <img src="docs/spark-readme-hero.svg" alt="T3 Code on cobec-spark — Spark LAN :5733" width="100%" />
</div>

## Cobec Spark

This repo is a **fork** of [pingdotgg/t3code](https://github.com/pingdotgg/t3code) for cobec-spark. Private origin: [jmartienzCobec/t3code](https://github.com/jmartienzCobec/t3code).

It is a **Spark managed service**, not a Funnel product. There is no `:443` path. Reach it on the LAN only.

| | |
|---|---|
| Spark LAN | `http://cobec-spark:5733` |
| systemd | `t3code-spark-dev.service` (`bun dev` from this tree) |
| Pairing URL | Last `pairingUrl:` line in `journalctl --user -u t3code-spark-dev.service` (Spark Dashboard `urlCommand` does the same) |
| Auth bootstrap | `scripts/spark-setup-persistent-auth.sh` → `~/.t3/dev/secrets/persistent-bootstrap.token` |

Vite is bound for a **public host** (`HOST=0.0.0.0`, `T3CODE_PUBLIC_HOST=cobec-spark`, `allowedHosts` includes `cobec-spark`) so HMR and the API/WebSocket proxy work from another machine on the tailnet — not only `localhost`. `VITE_DEV_SERVER_URL=http://cobec-spark:5733`.

```bash
# one-click pair URL (writes/reuses the token, then restart the unit)
./scripts/spark-setup-persistent-auth.sh
systemctl --user restart t3code-spark-dev.service

# rotate the token
./scripts/spark-setup-persistent-auth.sh --rotate
```

Anyone who can hit `:5733` and knows the bootstrap token gets owner access. Keep it on Spark LAN; do not Funnel it.

Upstream install / contribute notes follow unchanged.

---

# T3 Code

T3 Code is a minimal web GUI for coding agents (currently Codex, Claude, and OpenCode, more coming soon).

## Installation

> [!WARNING]
> T3 Code currently supports Codex, Claude, and OpenCode.
> Install and authenticate at least one provider before use:
>
> - Codex: install [Codex CLI](https://developers.openai.com/codex/cli) and run `codex login`
> - Claude: install [Claude Code](https://claude.com/product/claude-code) and run `claude auth login`
> - OpenCode: install [OpenCode](https://opencode.ai) and run `opencode auth login`

### Run without installing

```bash
npx t3
```

### Desktop app

Install the latest version of the desktop app from [GitHub Releases](https://github.com/pingdotgg/t3code/releases), or from your favorite package registry:

#### Windows (`winget`)

```bash
winget install T3Tools.T3Code
```

#### macOS (Homebrew)

```bash
brew install --cask t3-code
```

#### Arch Linux (AUR)

```bash
yay -S t3code-bin
```

## Some notes

We are very very early in this project. Expect bugs.

We are not accepting contributions yet.

Observability guide: [docs/observability.md](./docs/observability.md)

## If you REALLY want to contribute still.... read this first

Before local development, prepare the environment and install dependencies:

```bash
# Optional: only needed if you use mise for dev tool management.
mise install
bun install .
```

Read [CONTRIBUTING.md](./CONTRIBUTING.md) before opening an issue or PR.

Need support? Join the [Discord](https://discord.gg/jn4EGJjrvv).
