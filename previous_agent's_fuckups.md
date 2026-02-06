# Previous Agent's Failure Analysis

This document outlines the critical errors made during the troubleshooting process for installing HY-Motion on Windows with an RTX 3070 8GB.

## Status: ✅ RESOLVED

**Resolution Date:** 2026-02-06
**Action Taken:** Clean reinstall following official top3d.ai guide

---

## The Failures (For Reference)

| # | Mistake | Severity | What Happened |
|---|---------|----------|---------------|
| 1 | **GGUF Flip-Flopping** | ⚠️ Medium | Deleted GGUF model claiming "dead end" — but GGUF IS supported |
| 2 | **Transformers Downgrade** | 🔴 Critical | Downgraded to 4.45.0 (too old for Qwen3 architecture) |
| 3 | **Auto-AWQ on Windows** | 🔴 Critical | Recommended Auto-AWQ which doesn't work on Windows |
| 4 | **BitsAndBytes DLL Mess** | ⚠️ Medium | Manual DLL patching without proper verification |
| 5 | **Config.json Hacks** | 🔴 Critical | Changed model_type from "qwen3" to "qwen2" |
| 6 | **Plugin Code Edits** | ⚠️ Medium | Modified nodes.py to mask errors instead of fixing root cause |

---

## Recovery Actions Completed

- [x] Removed corrupted conda environment (`comfy311`)
- [x] Deleted corrupted `ComfyUI_py311` folder
- [x] Updated documentation guides with correct information
- [ ] Fresh installation following official guide

---

## Lessons Learned

1. **GGUF IS supported** for the text encoder on Windows
2. **Don't downgrade transformers** below 4.50 for Qwen3 models
3. **Auto-AWQ** requires WSL2 on Windows — avoid it
4. **BitsAndBytes** on Windows is fragile — GGUF is more reliable
5. **Never hack model config.json** — find the right model version instead

---

## Correct Configuration for RTX 3070 8GB

| Component | Recommended | VRAM |
|-----------|-------------|------|
| Motion Model | HY-Motion-1.0-Lite | ~4GB |
| Text Encoder | GGUF Q4_K_M or int4 | ~4-5GB |
| Total | - | ~8-9GB |

Use `offload_to_cpu: True` in ComfyUI nodes if hitting VRAM limits.
