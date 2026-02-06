# HY-Motion Setup Verification

Run these checks to confirm your setup is ready for animation generation.

---

## 1. Verify Conda Environment

```bash
conda activate comfy311
python --version
```

**Expected:** `Python 3.11.x`

---

## 2. Verify Installed Packages

```bash
pip list | grep -E "torch|transformers|fbxsdkpy"
```

**Windows PowerShell:**
```powershell
pip list | Select-String -Pattern "torch|transformers|fbxsdkpy"
```

**Expected:**
| Package | Version | Notes |
|---------|---------|-------|
| `torch` | 2.x.x+cu124 | Must have `cu124` for CUDA |
| `transformers` | 5.x+ | Must be 4.50+ for Qwen3 |
| `fbxsdkpy` | 2020.1.post2 | Required for FBX export |

---

## 3. Verify Model Files

### HY-Motion Lite Model
```bash
ls ComfyUI_py311/models/HY-Motion/ckpts/tencent/HY-Motion-1.0-Lite/
```

**Expected files:**
- `config.yml` (~1KB)
- `latest.ckpt` (~1.8GB)

---

## 4. ComfyUI Node Settings

| Node | Setting | Value |
|------|---------|-------|
| **HYMotion Load LLM** | quantization | `int4` |
| **HYMotion Load LLM** | offload_to_cpu | `True` |
| **HYMotion Load Network** | model_name | `HY-Motion-1.0-Lite` |

---

## 5. Test Generation

1. Open: http://127.0.0.1:8188
2. Load workflow from: `custom_nodes/ComfyUI-HY-Motion1/workflow/`
3. Enter prompt: `A person walking forward`
4. Queue Prompt
5. First run: ~90s (model loading). Subsequent: ~45-60s.

---

## ❓ Common Issues

| Error | Solution |
|-------|----------|
| `CUDA out of memory` | Set `offload_to_cpu: True`, use Lite model |
| `Architecture not supported` | `pip install -U transformers` |
| `bitsandbytes CUDA failed` | Use `int4` quantization instead |
| `FBX export fails` | Verify Python 3.11 (not 3.12/3.13) |
| `Module not found` | Re-run `pip install -r requirements.txt` |
